function P = changeLine(P, line, vector)
   len = length(vector);
   for i=1:len
       P(line, vector(i)) = 1/len;
   end
end