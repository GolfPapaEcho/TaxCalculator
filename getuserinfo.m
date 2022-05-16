function [year, isBlind, ageRange, isMarried, income] = ...
    getuserinfo()
%Gets User Information 
year = input('Enter Tax Year Ending (2012 or 2013) :');
while (year ~= 2012) && (year ~= 2013)
        year = input('Enter Tax Year Ending (2012 or 2013) :');
end

blindQ = input('Registered Blind? (Y/N) :', 's');
while (blindQ ~= 'Y') && (blindQ ~= 'N')

        blindQ = input('Registered Blind? (Y/N) :', 's');
end
isBlind = (blindQ == 'Y');

disp('Age Ranges: for 16 to 64 Enter "1"')
disp('Age Ranges: for 65 to 74 Enter "2"')
disp('Age Ranges: for 75+ Enter "3"')
ageRange = input('Enter Age Range (1, 2, or 3) :');
while (ageRange ~= 1) && (ageRange ~=  2) && (ageRange ~= 3)
    ageRange = input('Enter Age Range (1, 2, or 3) :');
end

isMarried = false;

if ageRange == 3
    marriedQ = input('Claiming married couples allowance? (Y/N) :', 's');
    while (marriedQ ~= 'Y') && (marriedQ ~= 'N')
        marriedQ = input('Claiming married couples allowance? (Y/N) :', 's');
    end
    isMarried = (marriedQ == 'Y');

end

income = input('Enter nonsavings income (GBP) :');
while (income < 0)
        income = input('Enter nonsavings income (GBP) :');
end