/*
 * Copyright (C) 2020+     Project "Sol" <https://gitlab.com/opfesoft/sol>, released under the GNU GPLv2 license: https://gitlab.com/opfesoft/sol/-/blob/master/deps/gpl-2.0.md; you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2016-2020 AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

#ifndef _AUTH_BIGNUMBER_H
#define _AUTH_BIGNUMBER_H

#include "Define.h"
#include <memory>

struct bignum_st;

class BigNumber
{
    public:
        BigNumber();
        BigNumber(BigNumber const& bn);
        BigNumber(uint32);
        ~BigNumber();

        void SetDword(uint32);
        void SetQword(uint64);
        void SetBinary(uint8 const* bytes, int32 len);
        void SetHexStr(char const* str);

        void SetRand(int32 numbits);

        BigNumber& operator=(BigNumber const& bn);

        BigNumber operator+=(BigNumber const& bn);
        BigNumber operator+(BigNumber const& bn)
        {
            BigNumber t(*this);
            return t += bn;
        }

        BigNumber operator-=(BigNumber const& bn);
        BigNumber operator-(BigNumber const& bn)
        {
            BigNumber t(*this);
            return t -= bn;
        }

        BigNumber operator*=(BigNumber const& bn);
        BigNumber operator*(BigNumber const& bn)
        {
            BigNumber t(*this);
            return t *= bn;
        }

        BigNumber operator/=(BigNumber const& bn);
        BigNumber operator/(BigNumber const& bn)
        {
            BigNumber t(*this);
            return t /= bn;
        }

        BigNumber operator%=(BigNumber const& bn);
        BigNumber operator%(BigNumber const& bn)
        {
            BigNumber t(*this);
            return t %= bn;
        }

        bool isZero() const;

        BigNumber ModExp(BigNumber const& bn1, BigNumber const& bn2);
        BigNumber Exp(BigNumber const&);

        int32 GetNumBytes(void);

        struct bignum_st *BN() { return _bn; }

        uint32 AsDword();

        std::unique_ptr<uint8[]> AsByteArray(int32 minSize = 0, bool littleEndian = true);

        char * AsHexStr() const;
        char * AsDecStr() const;

    private:
        struct bignum_st *_bn;

};
#endif

