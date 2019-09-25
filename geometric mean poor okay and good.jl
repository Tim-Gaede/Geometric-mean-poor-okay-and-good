# Beginner's Lesson incorporating:
# overflow, type conversions, logarithms, and formatting.

# It also showcases Julia's ability to use standard mathematical notation.

using Formatting

fmd(n, decimals) = format(n, commas=true, precision=decimals)


function textOfInts(a, width_total)
    size_max = 0
    a_fmd = []
    for aᵢ in a
        aᵢ_fmd = format(aᵢ, commas=true)
        push!(a_fmd, aᵢ_fmd)

        if length(aᵢ_fmd) > size_max
            size_max = length(aᵢ_fmd)
        end

    end

    padding = 2
    numCols = width_total ÷ (size_max + padding)

    result = ""
    for i = 1 : length(a_fmd)
        result *= (lpad(a_fmd[i], size_max) * " "^padding)

        if i % numCols == 0
            result *= "\n"
        end
    end


    result # returned
end


function sizeLongest(a)
    sizeLongest = 0
    for aᵢ in a
        if length(aᵢ) > sizeLongest
            sizeLongest = length(aᵢ)
        end
    end

    sizeLongest # returned
end

meanGeoPoor(a) = prod(a)^(1 / length(a))

function meanGeoOkay(a)
    Πaᵢ = 1.0 #<--What happens if this is changed to 1? (without the decimal)
    for aᵢ in a
        Πaᵢ *= aᵢ
    end

    Πaᵢ^(1/length(a)) # returned
end

function meanGeoGood(a)
# The geometric mean may be best thought of as
# the antilogarithm of the average logarithm

    ∑log_aᵢ = 0.0
    for aᵢ in a
        ∑log_aᵢ += log(aᵢ)
    end

    exp(∑log_aᵢ / length(a)) # returned
end



function main()
    width_REPL = 50
    println("\n", "-"^width_REPL, "\n")

    populations = [103281, 9823485]

    println("Populations:")
    print(textOfInts(populations, width_REPL))


    println("\n"^2)
    println("Computing the geometric mean three different ways:\n")
    println("meanGeoPoor(): ", fmd(meanGeoPoor(populations), 1))
    println("meanGeoOkay(): ", fmd(meanGeoOkay(populations), 1))
    println("meanGeoGood(): ", fmd(meanGeoGood(populations), 1))

    println("\n"^4)
    println("Now, let's push one more value into the populations array:\n")

    push!(populations, 1000243)
    println("Populations:")
    print(textOfInts(populations, width_REPL))





    println("\n"^2)
    println("meanGeoPoor()'s prod(a) now returns a negative value.\n",
            "This is due to the limited memory (64 bits) prod(a) has\n",
            "allocated for its returned value.\n\n",
            "meanGeoPoor() would therefore crash trying to raise a\n",
            "negative number to a fractional power.\n")

    println("\n")
    println("However, the remaining two functions still work:\n")

    #println("meanGeoPoor(): ", fmd(meanGeoPoor(populations), 1))
    println("meanGeoOkay(): ", fmd(meanGeoOkay(populations), 1))
    println("meanGeoGood(): ", fmd(meanGeoGood(populations), 1))

    println("\n"^4)
    println("Now, let's push some more values\n",
            "into the populations array:\n")

    for cnt = 1 : 10
        num = 10^(2*rand() + 5)
        pop = convert(Int, floor(num))
        push!(populations, pop)
    end
    println("Populations:")
    print(textOfInts(populations, width_REPL))

    println("\n")
    println("meanGeoOkay(): ", fmd(meanGeoOkay(populations), 1))
    println("meanGeoGood(): ", fmd(meanGeoGood(populations), 1))
    println("\n"^2)
    println("It looks like the the two remaining functions\n",
            "are still in agreement.")


    println("\n"^4)
    println("Let's push several more values\n",
            "into the populations array:\n")

    for cnt = 1 : 100
        num = 10^(2*rand() + 5)
        pop = convert(Int, floor(num))
        push!(populations, pop)
    end

    println("Populations:")
    print(textOfInts(populations, width_REPL))

    println("\n"^3)
    println("Computing the geometric mean the two remaining ways:\n")

    #println("meanGeoPoor(): ", fmd(meanGeoPoor(populations), 1))
    println("meanGeoOkay(): ", fmd(meanGeoOkay(populations), 1))
    println("meanGeoGood(): ", fmd(meanGeoGood(populations), 1))



    println("\n"^4)
    println("Here we see that meanGeoOkay did not crash but\n",
            "returned a value of: Inf (infinity)")

end
main()
