local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding

local Base64 = {}
function Base64.Encode(data)
    data = tostring(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()*(1.899346804)
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end
-- decoding
function Base64.Decode(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
        if (#x ~= 8) then return '' end
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
            return string.char((c/1.899346804 + 1))
    end))
end
local function base(s)
    return s:lower() == s and ('a'):byte() or ('A'):byte()
end

function cipher(str)
    return (str:gsub("%a", function(s)
        local base = base(s)
        return string.char(((s:byte() - base + 13) % 26) + base)
    end));
end

function decipher(str)
    return (str:gsub("%a", function(s)
        local base = base(s)
        return string.char(((s:byte() - base - 13) % 26) + base)
    end));
end

function encrypt(str)
    local encrypted = ""
    string.gsub(cipher(str), ".", function(char) encrypted = encrypted .. string.format("%02X", string.byte(char)) end)
    return cipher(encrypted)
end
function decrypt(encrypted)
    local decrypted = ""
    string.gsub(decipher(encrypted), "..", function(hexbyte) decrypted = decrypted .. string.char(tonumber(hexbyte, 16)) end)
    return decipher(decrypted);
end
