module SudokuSolver

    export
    numIsValidForAllColumnsByRow,
    numIsValidForAllRowsByColumn,
    getRowInitQuad,
    getColInitQuad,
    numIsValidForTheQuadByRowAndColumn,
    numIsValidForAllRowColumnAndHisQuad,
    numIsValidInQuad,
    allPossibilities,
    valuesAvailable,
    invalidRowNumbers,
    rowsNotEmpty

    allPossibilities = [x for x in 1:9]
    valuesAvailable(x) = [setdiff(allPossibilities, x);]
    invalidRowNumbers(grid, col) = [x for x in grid[:, col] if x != 0]
    rowsNotEmpty(grid, col) = findall( x -> x == 0, grid[:, col])

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

    function numIsValidForAllRowColumnAndHisQuad(grid, row, col, num)

        if !numIsValidForAllColumnsByRow(grid, row, num)
            return false
        end

        if !numIsValidForAllRowsByColumn(grid, col, num)
            return false
        end

        if !numIsValidForTheQuadByRowAndColumn(grid, row, col, num)
            return false
        end

        true
    end

end
