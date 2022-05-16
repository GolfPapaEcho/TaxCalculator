function XS = excess(Income, isMarried, TaxATable)
%Works out amount to taken from Allowances if Income > incomelimit

if isMarried
    
    XS = (Income - TaxATable.incomelimit(2))/2;

else
    XS = (Income - TaxATable.incomelimit(1))/2;
end

