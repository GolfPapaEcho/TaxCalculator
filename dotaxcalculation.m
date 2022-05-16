function [income taxableIncome rate netIncome] = ...
    dotaxcalculation(year, isBlind, ageRange, isMarried, income)
%calculates tax



%Enter allowance (named *a*) variables for correct year
%'personala' (ageRange) ie [16years+, 65years+, 75years+]
%'incomelimit' [universal ageaforall>64]


TaxAllowTableTYE12 = struct('blinda',1980, 'personala',[7475, 9940, 10090],...
    'incomelimit', [100000, 24000],...
    'marriedamax', 7295, 'marriedamin', 2800);
TaxAllowTableTYE13 = struct('blinda',2100, 'personala',[8105, 10500, 10660],...
    'incomelimit', [100000, 25400],...
    'marriedamax', 7705, 'marriedamin', 2960);

TaxATable = [TaxAllowTableTYE12, TaxAllowTableTYE13];

yRef = year - 2011;             %Reference year to TaxATable



%Common allowance calculation        
if income < TaxATable(yRef).incomelimit(1)
            allowance = TaxATable(yRef).personala(ageRange);
    elseif income >= (TaxATable(yRef).incomelimit + ...
            2*TaxATable(yRef).personala(ageRange))
            allowance = 0;
    else
            allowance = TaxATable(yRef).personala(ageRange) - ...
                excess(income, isMarried, TaxATable(yRef));  
            %See excess function
end

%Married couples allowance calculation
if (ageRange == 3) && (isMarried)
    
    personalADiff = TaxATable(yRef).personala(ageRange) - ...
        TaxATable(yRef).personala(1);
    marriedADiff = TaxATable(yRef).marriedamax - ...
        TaxATable(yRef).marriedamin;
    
    if  income < TaxATable(yRef).incomelimit(2) + 2*personalADiff
        allowance = allowance + 0.1*TaxATable(yRef).marriedamax;
    
    elseif excess(income, isMarried,TaxATable(yRef)) >= personalADiff + ...
            marriedADiff
        allowance = allowance + 0.1*TaxATable(yRef).marriedamin;

    else
        xsSubPersonalADiff = excess(income, isMarried, TaxATable(yRef)) - ...
            personalADiff;
        allowance  = TaxATable(yRef).personala(1) +...
            0.1*(TaxATable(yRef).marriedamax - xsSubPersonalADiff);
    end
   
        
end

%Blind Persons allowance calculation
if isBlind
    allowance = allowance + TaxATable(yRef).blinda;
end

%The Tax calc
TaxRate = struct('zero', 1 , 'basic', 0.8, 'higher', 0.6, 'additional', 0.5);

TaxBandTYE12 = struct('basic', 0, 'higher', 35000, 'additional', 150000);
TaxBandTYE13 = struct('basic', 0, 'higher', 34370, 'additional', 150000);
TaxBand = [TaxBandTYE12, TaxBandTYE13];

%Low income case fix for taxable income
if income < TaxATable(yRef).personala(ageRange)
    taxableIncome = 0;
elseif allowance >= income
    taxableIncome = 0;
else
    taxableIncome = income - allowance;
end

%The actual tax calc!
if (income < TaxATable(yRef).personala(ageRange)) || (allowance >= income)
    rate = 1 - TaxRate.zero;
    netIncome = TaxRate.zero*income;

elseif (income > TaxATable(yRef).personala(ageRange)) && ...
        (income <= TaxBand(yRef).higher)
    rate = 1 - TaxRate.basic;
    netIncome = TaxRate.basic*taxableIncome + allowance;

elseif income <= TaxBand(yRef).additional
    rate = 1 - TaxRate.higher;
    netIncome = TaxRate.higher*taxableIncome + allowance;

else rate = TaxRate.additional;
    netIncome = TaxRate.additional*taxableIncome + allowance;
end



