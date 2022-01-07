function ret = unitvec(vector)
    mag = sqrt(sum(vector.^2));
    ret = bsxfun(@rdivide, vector, mag);
end