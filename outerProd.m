function Tensor = outerProd(VecArray)

n = length(VecArray);
[AugArray{1:n}] = ndgrid(VecArray{:});
Tensor = AugArray{1};
for i = 2:n
    Tensor = Tensor.*AugArray{i};
end

end

