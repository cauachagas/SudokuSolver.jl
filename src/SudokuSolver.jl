module SudokuSolver

    export
    numIsValidForAllCollumsMatrixByRow,
    numIsValidForAllRowsMatrixByCollumn,
    numIsValidForTheQuadByRowAndCollumn

    function numIsValidForAllCollumsMatrixByRow(grid, row, num)
        isnothing(findfirst( x -> x == num, grid[row, :]))
    end

    function numIsValidForAllRowsMatrixByCollumn(grid, col, num)
        isnothing(findfirst( x -> x == num, grid[:, col]))
    end

end
