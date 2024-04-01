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
    @test numIsValidForAllCollumsMatrixByRow(problem, row, num) == false
end

@testset "Test All invalid Numbers for second row" begin
    row = 2
    invalidNumbers = [x for x in problem[row, :] if x != 0]
    for invalidNum ∈ invalidNumbers
        @test numIsValidForAllCollumsMatrixByRow(problem, row, invalidNum) == false
    end
end

@testset "Test All invalid Numbers for All rows" begin
    rows = 1:9
    for row ∈ rows
        invalidNumbers = [x for x in problem[row, :] if x != 0]
        for invalidNum ∈ invalidNumbers
            @test numIsValidForAllCollumsMatrixByRow(problem, row, invalidNum) == false
        end
    end
end

@testset "Number 2 is valid for second row" begin
    row = 2
    num = 2
    @test numIsValidForAllCollumsMatrixByRow(problem, row, num) == true
end

@testset "Test All valid Numbers for All rows" begin
    rows = 1:9
    for row ∈ rows
        invalidNumbers = [x for x in problem[row, :] if x != 0]
        for validNum ∈ valuesAvailable(invalidNumbers)
            @test numIsValidForAllCollumsMatrixByRow(problem, row, validNum) == true
        end
    end
end

@testset "Number 7 is invalid for first col" begin
    col = 1
    num = 7
    @test numIsValidForAllRowsMatrixByCollumn(problem, col, num) == false
end

@testset "Test All invalid Numbers for fifth col" begin
    col = 5
    invalidNumbers = [x for x in problem[:, col] if x != 0]
    for invalidNum ∈ invalidNumbers
        @test numIsValidForAllRowsMatrixByCollumn(problem, col, invalidNum) == false
    end
end

@testset "Test All invalid Numbers for All cols" begin
    cols = 1:9
    for col ∈ cols
        invalidNumbers = [x for x in problem[:, col] if x != 0]
        for invalidNum ∈ invalidNumbers
            @test numIsValidForAllRowsMatrixByCollumn(problem, col, invalidNum) == false
        end
    end
end

@testset "Number 1 is valid for sixth col" begin
    col = 6
    num = 1
    @test numIsValidForAllRowsMatrixByCollumn(problem, col, num) == true
end

@testset "Test All valid Numbers for All cols" begin
    cols = 1:9
    for col ∈ cols
        invalidNumbers = [x for x in problem[:, col] if x != 0]
        for validNum ∈ valuesAvailable(invalidNumbers)
            @test numIsValidForAllRowsMatrixByCollumn(problem, col, validNum) == true
        end
    end
end

@testset "get Row Init Grid using any Row" begin

    @testset "Using the range 1:3 the init grid is 1" begin
        for i = 1:3
            @test getRowInitGrid(i) == 1
        end
    end

    @testset "Using the range 4:6 the init grid is 4" begin
        for i = 4:6
            @test getRowInitGrid(i) == 4
        end
    end

    @testset "Using the range 7:9 the init grid is 7" begin
        for i = 7:9
            @test getRowInitGrid(i) == 7
        end
    end
end

@testset "get Col Init Grid using any Col" begin

    @testset "Using the range 1:3 the init grid is 1" begin
        for i = 1:3
            @test getColInitGrid(i) == 1
        end
    end

    @testset "Using the range 4:6 the init grid is 4" begin
        for i = 4:6
            @test getColInitGrid(i) == 4
        end
    end

    @testset "Using the range 7:9 the init grid is 7" begin
        for i = 7:9
            @test getColInitGrid(i) == 7
        end
    end

end
