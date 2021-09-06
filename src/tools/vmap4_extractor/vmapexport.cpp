/*
 * Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU AGPLv3 license: https://gitlab.com/opfesoft/sol/-/blob/master/LICENSE.md
 * Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: http://github.com/azerothcore/azerothcore-wotlk/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#define _CRT_SECURE_NO_DEPRECATE
#include <cstdio>
#include <iostream>
#include <vector>
#include <list>
#include <errno.h>

#include <sys/stat.h>

#undef min
#undef max

//#pragma warning(disable : 4505)
//#pragma comment(lib, "Winmm.lib")

#include <map>

//From Extractor
#include "adtfile.h"
#include "wdtfile.h"
#include "dbcfile.h"
#include "wmo.h"
#include "mpq_libmpq04.h"

#include "vmapexport.h"

//------------------------------------------------------------------------------
// Defines

#define MPQ_BLOCK_SIZE 0x1000

//-----------------------------------------------------------------------------

extern ArchiveSet gOpenArchives;

typedef struct
{
    char name[64];
    unsigned int id;
}map_id;

std::vector<map_id> map_ids;
uint32 map_count;
char output_path[128]=".";
char input_path[1024]=".";
bool hasInputPathParam = false;
bool preciseVectorData = false;
std::unordered_map<std::string, WMODoodadData> WmoDoodads;

// Constants

//static const char * szWorkDirMaps = ".\\Maps";
const char* szWorkDirWmo = "./Buildings";
const char* szRawVMAPMagic = "VMAP072";

std::map<std::pair<uint32, uint16>, uint32> uniqueObjectIds;

uint32 GenerateUniqueObjectId(uint32 clientId, uint16 clientDoodadId)
{
    return uniqueObjectIds.emplace(std::make_pair(clientId, clientDoodadId), uniqueObjectIds.size() + 1).first->second;
}

// Local testing functions

bool FileExists(const char* file)
{
    if (FILE* n = fopen(file, "rb"))
    {
        fclose(n);
        return true;
    }
    return false;
}

void strToLower(char* str)
{
    while(*str)
    {
        *str=tolower(*str);
        ++str;
    }
}

bool ExtractSingleWmo(std::string& fname)
{
    // Copy files from archive
    std::string originalName = fname;

    char szLocalFile[1024];
    char* plain_name = GetPlainName(&fname[0]);
    fixnamen(plain_name, strlen(plain_name));
    fixname2(plain_name, strlen(plain_name));
    sprintf(szLocalFile, "%s/%s", szWorkDirWmo, plain_name);

    if (FileExists(szLocalFile))
        return true;

    int p = 0;
    // Select root wmo files
    char const* rchr = strrchr(plain_name, '_');
    if (rchr != NULL)
    {
        char cpy[4];
        memcpy(cpy, rchr, 4);
        for (int i = 0; i < 4; ++i)
        {
            int m = cpy[i];
            if (isdigit(m))
                p++;
        }
    }

    if (p == 3)
        return true;

    bool file_ok = true;
    printf("Extracting %s\n", originalName.c_str());
    WMORoot froot(originalName);
    if(!froot.open())
    {
        printf("Couldn't open RootWmo!!!\n");
        return true;
    }
    FILE *output = fopen(szLocalFile,"wb");
    if(!output)
    {
        printf("couldn't open %s for writing!\n", szLocalFile);
        return false;
    }
    froot.ConvertToVMAPRootWmo(output);
    WMODoodadData& doodads = WmoDoodads[plain_name];
    std::swap(doodads, froot.DoodadData);
    int Wmo_nVertices = 0;
    //printf("root has %d groups\n", froot->nGroups);
    if (froot.nGroups !=0)
    {
        for (uint32 i = 0; i < froot.nGroups; ++i)
        {
            if (fname.length() > 1023)
            {
                printf("File name too long");
                return false;
            }
            else if (fname.length() < 4)
            {
                printf("File name too short");
                return false;
            }
            char temp[1024];
            strncpy(temp, fname.c_str(), 1023);
            temp[fname.length()-4] = 0;
            char groupFileName[1024];
            int n = snprintf(groupFileName, 1024, "%s_%03u.wmo", temp, i);
            if (n < 0 || (size_t)n >= sizeof temp)
            {
                printf("Error creating group file name");
                return false;
            }
            //printf("Trying to open groupfile %s\n",groupFileName);

            string s = groupFileName;
            WMOGroup fgroup(s);
            if(!fgroup.open())
            {
                printf("Could not open all Group file for: %s\n", plain_name);
                file_ok = false;
                break;
            }

            Wmo_nVertices += fgroup.ConvertToVMAPGroupWmo(output, &froot, preciseVectorData);
            for (uint16 groupReference : fgroup.DoodadReferences)
            {
                if (groupReference >= doodads.Spawns.size())
                    continue;

                uint32 doodadNameIndex = doodads.Spawns[groupReference].NameIndex;
                if (froot.ValidDoodadNames.find(doodadNameIndex) == froot.ValidDoodadNames.end())
                    continue;

                doodads.References.insert(groupReference);
            }
        }
    }

    fseek(output, 8, SEEK_SET); // store the correct no of vertices
    fwrite(&Wmo_nVertices,sizeof(int),1,output);
    fclose(output);

    // Delete the extracted file in the case of an error
    if (!file_ok)
        remove(szLocalFile);
    return true;
}

void ParsMapFiles()
{
    char fn[512];
    //char id_filename[64];
    for (unsigned int i=0; i<map_count; ++i)
    {
        sprintf(fn,"World\\Maps\\%s\\%s.wdt", map_ids[i].name, map_ids[i].name);
        WDTFile WDT(fn,map_ids[i].name);
        if (WDT.init(map_ids[i].id))
        {
            printf("Processing Map %u\n", map_ids[i].id);
            for (int x=0; x<64; ++x)
            {
                for (int y=0; y<64; ++y)
                {
                    if (ADTFile *ADT = WDT.GetMap(x,y))
                    {
                        //sprintf(id_filename,"%02u %02u %03u",x,y,map_ids[i].id);//!!!!!!!!!
                        ADT->init(map_ids[i].id, x, y);
                        delete ADT;
                    }
                }
            }
        }
    }
}

void getGamePath()
{
    strcpy(input_path,"Data/");
}

bool scan_patches(char* scanmatch, std::vector<std::string>& pArchiveNames)
{
    int i;
    char path[512];

    for (i = 1; i <= 99; i++)
    {
        if (i != 1)
        {
            sprintf(path, "%s-%d.MPQ", scanmatch, i);
        }
        else
        {
            sprintf(path, "%s.MPQ", scanmatch);
        }
#ifdef __linux__
        if(FILE* h = fopen64(path, "rb"))
#else
        if(FILE* h = fopen(path, "rb"))
#endif
        {
            fclose(h);
            //matches.push_back(path);
            pArchiveNames.push_back(path);
        }
    }

    return(true);
}

bool fillArchiveNameVector(std::vector<std::string>& pArchiveNames)
{
    if(!hasInputPathParam)
        getGamePath();

    printf("\nGame path: %s\n", input_path);

    char path[512];
    string in_path(input_path);
    std::vector<std::string> locales, searchLocales;

    searchLocales.push_back("enGB");
    searchLocales.push_back("enUS");
    searchLocales.push_back("deDE");
    searchLocales.push_back("esES");
    searchLocales.push_back("frFR");
    searchLocales.push_back("koKR");
    searchLocales.push_back("zhCN");
    searchLocales.push_back("zhTW");
    searchLocales.push_back("enCN");
    searchLocales.push_back("enTW");
    searchLocales.push_back("esMX");
    searchLocales.push_back("ruRU");

    for (std::vector<std::string>::iterator i = searchLocales.begin(); i != searchLocales.end(); ++i)
    {
        std::string localePath = in_path + *i;
        // check if locale exists:
        struct stat status;
        if (stat(localePath.c_str(), &status))
            continue;
        if ((status.st_mode & S_IFDIR) == 0)
            continue;
        printf("Found locale '%s'\n", i->c_str());
        locales.push_back(*i);
    }
    printf("\n");

    // open locale expansion and common files
    printf("Adding data files from locale directories.\n");
    for (std::vector<std::string>::iterator i = locales.begin(); i != locales.end(); ++i)
    {
        pArchiveNames.push_back(in_path + *i + "/locale-" + *i + ".MPQ");
        pArchiveNames.push_back(in_path + *i + "/expansion-locale-" + *i + ".MPQ");
        pArchiveNames.push_back(in_path + *i + "/lichking-locale-" + *i + ".MPQ");
    }

    // open expansion and common files
    pArchiveNames.push_back(input_path + string("common.MPQ"));
    pArchiveNames.push_back(input_path + string("common-2.MPQ"));
    pArchiveNames.push_back(input_path + string("expansion.MPQ"));
    pArchiveNames.push_back(input_path + string("lichking.MPQ"));

    // now, scan for the patch levels in the core dir
    printf("Scanning patch levels from data directory.\n");
    int n = snprintf(path, 512, "%spatch", input_path);
    if (n < 0 || (size_t)n >= sizeof path)
    {
        printf("Error creating path name");
        return false;
    }
    if (!scan_patches(path, pArchiveNames))
        return(false);

    // now, scan for the patch levels in locale dirs
    printf("Scanning patch levels from locale directories.\n");
    bool foundOne = false;
    for (std::vector<std::string>::iterator i = locales.begin(); i != locales.end(); ++i)
    {
        printf("Locale: %s\n", i->c_str());
        n = snprintf(path, 512, "%s%s/patch-%s", input_path, i->c_str(), i->c_str());
        if (n < 0 || (size_t)n >= sizeof path)
        {
            printf("Error creating path name");
            return false;
        }
        if(scan_patches(path, pArchiveNames))
            foundOne = true;
    }

    printf("\n");

    if(!foundOne)
    {
        printf("no locale found\n");
        return false;
    }

    return true;
}

bool processArgv(int argc, char ** argv, const char *versionString)
{
    bool result = true;
    hasInputPathParam = false;
    preciseVectorData = false;

    for(int i = 1; i < argc; ++i)
    {
        if(strcmp("-s",argv[i]) == 0)
        {
            preciseVectorData = false;
        }
        else if(strcmp("-d",argv[i]) == 0)
        {
            if((i+1)<argc)
            {
                hasInputPathParam = true;
                strcpy(input_path, argv[i+1]);
                if (input_path[strlen(input_path) - 1] != '\\' && input_path[strlen(input_path) - 1] != '/')
                    strcat(input_path, "/");
                ++i;
            }
            else
            {
                result = false;
            }
        }
        else if(strcmp("-?",argv[1]) == 0)
        {
            result = false;
        }
        else if(strcmp("-l",argv[i]) == 0)
        {
            preciseVectorData = true;
        }
        else
        {
            result = false;
            break;
        }
    }
    if(!result)
    {
        printf("Extract %s.\n",versionString);
        printf("%s [-?][-s][-l][-d <path>]\n", argv[0]);
        printf("   -s : (default) small size (data size optimization), ~500MB less vmap data.\n");
        printf("   -l : large size, ~500MB more vmap data. (might contain more details)\n");
        printf("   -d <path>: Path to the vector data source folder.\n");
        printf("   -? : This message.\n");
    }
    return result;
}


//xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
// Main
//
// The program must be run with two command line arguments
//
// Arg1 - The source MPQ name (for testing reading and file find)
// Arg2 - Listfile name
//

int main(int argc, char ** argv)
{
    bool success=true;
    const char *versionString = "V4.00 2012_02";

    // Use command line arguments, when some
    if (!processArgv(argc, argv, versionString))
        return 1;

    // some simple check if working dir is dirty
    else
    {
        std::string sdir = std::string(szWorkDirWmo) + "/dir";
        std::string sdir_bin = std::string(szWorkDirWmo) + "/dir_bin";
        struct stat status;
        if (!stat(sdir.c_str(), &status) || !stat(sdir_bin.c_str(), &status))
        {
            printf("Your output directory seems to be polluted, please use an empty directory!\n");
            printf("<press return to exit>");
            char garbage[2];
            return scanf("%c", garbage);
        }
    }

    printf("Extract %s. Beginning work ....\n",versionString);
    //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    // Create the working directory
    if (mkdir(szWorkDirWmo
#if defined(__linux__)
                    , 0711
#endif
                    ))
            success = (errno == EEXIST);

    // prepare archive name list
    std::vector<std::string> archiveNames;
    fillArchiveNameVector(archiveNames);
    for (size_t i=0; i < archiveNames.size(); ++i)
    {
        MPQArchive *archive = new MPQArchive(archiveNames[i].c_str());
        if (gOpenArchives.empty() || gOpenArchives.front() != archive)
            delete archive;
    }

    if (gOpenArchives.empty())
    {
        printf("FATAL ERROR: None MPQ archive found by path '%s'. Use -d option with proper path.\n",input_path);
        return 1;
    }

    //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    //map.dbc
    if (success)
    {
        DBCFile * dbc = new DBCFile("DBFilesClient\\Map.dbc");
        if (!dbc->open())
        {
            delete dbc;
            printf("FATAL ERROR: Map.dbc not found in data file.\n");
            return 1;
        }
        map_count=dbc->getRecordCount();
        map_ids.resize(map_count);
        for (unsigned int x=0;x<map_count;++x)
        {
            map_ids[x].id = dbc->getRecord(x).getUInt(0);

            char const* map_name = dbc->getRecord(x).getString(1);
            size_t max_map_name_length = sizeof(map_ids[x].name);
            if (strlen(map_name) >= max_map_name_length)
            {
                delete dbc;
                printf("FATAL ERROR: Map name too long.\n");
                return 1;
            }

            strncpy(map_ids[x].name, map_name, max_map_name_length);
            map_ids[x].name[max_map_name_length - 1] = '\0';
            printf("Map - %s\n",map_ids[x].name);
        }


        delete dbc;
        ParsMapFiles();
        //nError = ERROR_SUCCESS;
        // Extract models, listed in DameObjectDisplayInfo.dbc
        ExtractGameobjectModels();
    }

    printf("\n");
    if (!success)
    {
        printf("ERROR: Extract %s. Work NOT complete.\n   Precise vector data=%d.\nPress any key.\n",versionString, preciseVectorData);
        getchar();
    }

    printf("Extract %s. Work complete. No errors.\n",versionString);
    return 0;
}
