function printVec(vec)


fprintf('%s\n', strjoin(cellstr(num2str(vec(:),'%.2f')),'   '));


end

