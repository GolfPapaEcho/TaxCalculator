                              function testpassed = ...
    testdotaxcalculation(year, isBlind, ageRange, isMarried, income,...
    expIncome, expTaxableIncome, expRate, expNetIncome)
%take inputs for  and excpected outputs for dotaxcalculation


%actual
[actIncome actTaxableIncome actRate actNetIncome] = ...
    dotaxcalculation(year, isBlind, ageRange, isMarried, income);

testpassed = true;
if expIncome ~= actIncome
    testpassed = false;
end

if expTaxableIncome ~= actTaxableIncome
    testpassed = false;
end

expRate = round(expRate*100);
actRate = round(actRate*100);
if expRate ~= actRate
    testpassed = false;
end

if expNetIncome ~= actNetIncome
    testpassed = false;
end

