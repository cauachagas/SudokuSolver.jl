module SudokuSolver

    export
    numIsValidForAllCollumsMatrixByRow,
    numIsValidForAllRowsMatrixByCollumn,
    getRowInitGrid, 
    getColInitGrid

    function getRowInitGrid(row)
        row - (row-1) % 3
    end

    function getColInitGrid(col)
        col - (col-1) % 3
    end

    function numIsValidForAllCollumsMatrixByRow(grid, row, num)
        isnothing(findfirst( x -> x == num, grid[row, :]))
    end

    function numIsValidForAllRowsMatrixByCollumn(grid, col, num)
        isnothing(findfirst( x -> x == num, grid[:, col]))
    end

end
