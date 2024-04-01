module SudokuSolver

    export
    numIsValidForAllColumnsByRow,
    numIsValidForAllRowsByColumn,
    getRowInitQuad,
    getColInitQuad,
    numIsValidForTheQuadByRowAndColumn,
    numIsValidForAllRowColumnAndHisQuad,
    numIsValidInQuad

    function getRowInitQuad(row)
        row - (row-1) % 3
    end

    function getColInitQuad(col)
        col - (col-1) % 3
    end

    function numIsValidForAllColumnsByRow(grid, row, num)
        isnothing(findfirst( x -> x == num, grid[row, :]))
    end

    function numIsValidForAllRowsByColumn(grid, col, num)
        isnothing(findfirst( x -> x == num, grid[:, col]))
    end

    function numIsValidInQuad(grid, num)
        isnothing(findfirst( x -> x == num, grid))
    end

    function numIsValidForTheQuadByRowAndColumn(grid, row, col, num; returnQuad=false)
        rowInit = getRowInitQuad(row)
        colInit = getColInitQuad(col)
        quad = grid[rowInit:(rowInit+2), colInit:(colInit+2)]
        if returnQuad
            return quad, numIsValidInQuad(quad , num)
        end
        numIsValidInQuad(quad , num)
    end

end
