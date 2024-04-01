using SudokuSolver
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

@testset "Number 8 is invalid for second row" begin
    row = 2
    num = 8
    @test numIsValidForAllColumnsByRow(problem, row, num) == false
end

@testset "Test All invalid Numbers for second row" begin
    row = 2
    invalidNumbers = [x for x in problem[row, :] if x != 0]
    for invalidNum ∈ invalidNumbers
        @test numIsValidForAllColumnsByRow(problem, row, invalidNum) == false
    end
end

@testset "Test All invalid Numbers for All rows" begin
    rows = 1:9
    for row ∈ rows
        invalidNumbers = [x for x in problem[row, :] if x != 0]
        for invalidNum ∈ invalidNumbers
            @test numIsValidForAllColumnsByRow(problem, row, invalidNum) == false
        end
    end
end

@testset "Number 2 is valid for second row" begin
    row = 2
    num = 2
    @test numIsValidForAllColumnsByRow(problem, row, num)
end

@testset "Test All valid Numbers for All rows" begin
    rows = 1:9
    for row ∈ rows
        invalidNumbers = [x for x in problem[row, :] if x != 0]
        for validNum ∈ valuesAvailable(invalidNumbers)
            @test numIsValidForAllColumnsByRow(problem, row, validNum)
        end
    end
end

@testset "Number 7 is invalid for first col" begin
    col = 1
    num = 7
    @test numIsValidForAllRowsByColumn(problem, col, num) == false
end

@testset "Test All invalid Numbers for fifth col" begin
    col = 5
    invalidNumbers = [x for x in problem[:, col] if x != 0]
    for invalidNum ∈ invalidNumbers
        @test numIsValidForAllRowsByColumn(problem, col, invalidNum) == false
    end
end

@testset "Test All invalid Numbers for All cols" begin
    cols = 1:9
    for col ∈ cols
        invalidNumbers = [x for x in problem[:, col] if x != 0]
        for invalidNum ∈ invalidNumbers
            @test numIsValidForAllRowsByColumn(problem, col, invalidNum) == false
        end
    end
end

@testset "Number 1 is valid for sixth col" begin
    col = 6
    num = 1
    @test numIsValidForAllRowsByColumn(problem, col, num)
end

@testset "Test All valid Numbers for All cols" begin
    cols = 1:9
    for col ∈ cols
        invalidNumbers = [x for x in problem[:, col] if x != 0]
        for validNum ∈ valuesAvailable(invalidNumbers)
            @test numIsValidForAllRowsByColumn(problem, col, validNum)
        end
    end
end

@testset "get Row Init Quad using any Row" begin

    @testset "Using the range 1:3 the init grid is 1" begin
        for i = 1:3
            @test getRowInitQuad(i) == 1
        end
    end

    @testset "Using the range 4:6 the init grid is 4" begin
        for i = 4:6
            @test getRowInitQuad(i) == 4
        end
    end

    @testset "Using the range 7:9 the init grid is 7" begin
        for i = 7:9
            @test getRowInitQuad(i) == 7
        end
    end
end

@testset "get Col Init Quad using any Col" begin

    @testset "Using the range 1:3 the init grid is 1" begin
        for i = 1:3
            @test getColInitQuad(i) == 1
        end
    end

    @testset "Using the range 4:6 the init grid is 4" begin
        for i = 4:6
            @test getColInitQuad(i) == 4
        end
    end

    @testset "Using the range 7:9 the init grid is 7" begin
        for i = 7:9
            @test getColInitQuad(i) == 7
        end
    end

end

@testset "Valid values for each quad" begin
    # Quads
    # | 1 | 4 | 7 |
    # | 2 | 5 | 8 |
    # | 3 | 6 | 9 |
    validNumbersByQuad = [8, 8, 8, 1, 8, 8, 1, 8, 8]
    quadNumber = 1
    for col ∈ 1:3:9
        for row ∈ 1:3:9
            quad = problem[row:(row+2), col:(col+2)]
            # @show row, col, validNumbersByQuad[quadNumber], quad
            @test numIsValidInQuad(quad, validNumbersByQuad[quadNumber])
            quadNumber += 1
        end
    end
end
