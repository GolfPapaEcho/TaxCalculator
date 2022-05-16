function calculatetax()
%This funtion gets user data and returns tax details



%obtaining paramereters from view 
[year, isBlind, ageRange, isMarried, income] = ...
    getuserinfo();

%call model
[income taxableIncome rate netIncome] = ...
    dotaxcalculation(year, isBlind, ageRange, isMarried, income);

%pass results to view
displaytaxresult(income, taxableIncome, rate, netIncome);

