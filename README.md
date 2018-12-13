# vhdl

this is something i made in work for university , helping some classmate , my work was make a IEEE float divider with 32 bits
but to help some classmate i made , 64 bits and 128 bits , the 128 i comment the rem , because use too much logic ports , but
will only complet with the rem , mod or something like that...


how it work ? 


any number in binary it can conveter to float number 

xxxx * 2^ n , will be u float number when u have the 1, at write place , 
when u get something like 84,12 u will need the ,12 that not get only with 2^n
but doing some skill in math , u can do this 


if ( xxxx > 2^n * 100 ) then
xxxx/100 , so i geting the ,12 and the 84 ...
end if;

if u have 10^m-100
if (xxxx > 2^n*10**m) then
xxxx/(10**m)
end if;

the only problem with this is because use to much disnecerry move , 
i dont know exatily how many float convertion exit in word . 

but this code will help to underdanstand ...


--------------------------------------------------------------------------------------------------------

--- if u use any of this code to get some money contate me the creato of this code and this math skill ,
but u can use if not use to get some money or something like that.

