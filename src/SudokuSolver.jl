module SudokuSolver

    export numIsValidForAllCollumsMatrixByRow

    function numIsValidForAllCollumsMatrixByRow(grid, row, num)
        isnothing(findfirst( x -> x == num, grid[row, :]))
    end

end
