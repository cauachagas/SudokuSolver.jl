using Test

problem = [
    3  4  5  0  0  0  0  0  8;
    6  1  0  0  8  3  5  4  9;
    7  9  0  0  4  5  0  0  6;
    0  0  0  1  5  7  0  0  0;
    0  0  0  0  6  4  9  0  0;
    0  7  1  9  0  0  4  0  0;
    0  0  9  0  2  0  6  0  4;
    0  5  0  0  1  0  0  0  0;
    2  0  6  0  0  0  3  0  0;
]

allPossibilities = [x for x in 1:9]
valuesAvailable(x) = [setdiff(allPossibilities, x);]
invalidRowNumbers(grid, col) = [x for x in grid[:, col] if x != 0]
rowsNotEmpty(grid, col) = findall( x -> x == 0, grid[:, col])

@testset "Incomplete solve for col = 1" begin
    grid = copy(problem)
    col = 1
    for row = 1:9
        if grid[row, col] == 0
            for num ∈ allPossibilities
                if numIsValidForAllRowColumnAndHisQuad(grid, row, col, num)
                    grid[row, col] = num
                    break
                end
            end
        end
    end

    @test grid[:, col] == [3, 6, 7, 4, 5, 8, 1, 0, 2]
end

@testset "Incomplete solve using valid numbers for col = 1" begin
    grid = copy(problem)
    col = 1
    invalidNumbers = invalidRowNumbers(grid, col)
    validNumbers = valuesAvailable(invalidNumbers)
    rows = rowsNotEmpty(grid, col)
    for row ∈ rows
        for num ∈ validNumbers
            if numIsValidForAllRowColumnAndHisQuad(grid, row, col, num)
                grid[row, col] = num
                break
            end
        end
    end

    @test grid[:, col] == [3, 6, 7, 4, 5, 8, 1, 0, 2]
end

@testset "Solve first column using circshift over validNumbers" begin
    grid = copy(problem)
    col = 1
    invalidNumbers = invalidRowNumbers(grid, col)
    validNumbers = valuesAvailable(invalidNumbers)
    rows = rowsNotEmpty(grid, col)
    for row ∈ rows
        for num ∈ validNumbers
            if numIsValidForAllRowColumnAndHisQuad(grid, row, col, num)
                grid[row, col] = num
                break
            end
        end
        if grid[row, col] == 0
            validNumbers = circshift(validNumbers, 1)
            for row ∈ rows
                for num ∈ validNumbers
                    if numIsValidForAllRowColumnAndHisQuad(grid, row, col, num)
                        grid[row, col] = num
                        break
                    end
                end
            end
        end

    end

    @test grid[:, col] == [3, 6, 7, 9, 5, 8, 1, 4, 2]
end

@testset "Create a function for solve col = 1" begin
    grid = copy(problem)
    col = 1
    invalidNumbers = invalidRowNumbers(grid, col)
    validNumbers = valuesAvailable(invalidNumbers)
    rows = rowsNotEmpty(grid, col)

    function solveCol(grid, rows, col, validNumbers)
        for row ∈ rows
            for num ∈ validNumbers
                if numIsValidForAllRowColumnAndHisQuad(grid, row, col, num)
                    grid[row, col] = num
                    break
                end
            end
            if grid[row, col] == 0
                return false
            end
        end
        return true
    end

    solveCol(grid, rows, col, validNumbers)
    @test grid[:, col] == [3, 6, 7, 4, 5, 8, 1, 0, 2]

    validNumbers = circshift(validNumbers, 1)
    solveCol(grid, rows, col, validNumbers)
    @test grid[:, col] == [3, 6, 7, 9, 5, 8, 1, 4, 2]

end

@testset "Solve the problem for col = 1" begin


    function putValues(row, col, grid, validNumbers)
        numbers = copy(validNumbers)
        for num ∈ numbers
            if numIsValidForAllRowColumnAndHisQuad(grid, row, col, num)
                grid[row, col] = num
                deleteat!(numbers,findfirst( x -> x == num, numbers))
                break
            end
        end
        return grid
    end

    function putValuesInAllRows(rows, col, grid, validNumbers)
        for row ∈ rows
            putValues(row, col, grid, validNumbers)
            if grid[row, col] == 0
                return false
            end
        end
        true
    end

    function solve(grid, col)
        rows = rowsNotEmpty(grid, col)
        invalidNumbers = invalidRowNumbers(grid, col)
        validNumbers = valuesAvailable(invalidNumbers)

        for i ∈ rows
            if putValuesInAllRows(rows, col, grid, validNumbers)
                break
            end
            circshift!(validNumbers, 1)
        end
        # while !putValuesInAllRows(rows, col, grid, validNumbers)
        #     circshift!(validNumbers, 1)
        # end

    end

    grid = copy(problem)
    col = 1
    solve(grid, col)
    @test grid[:, col] == [3, 6, 7, 9, 5, 8, 1, 4, 2]

end
