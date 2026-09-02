function [row, col] = index_to_rowcol(index, m, n)
% Function to convert linear index to row-column order (row-wise counting)
    % row-major order: left to right in each row, top to bottom
    row = ceil(index / n);
    col = mod(index - 1, n) + 1;
end
