test_that("Auto Discovery No Arguments", {
    expect_error(auto_discover())
})

if (authenticated) {
    test_that("Invalid Grain", {
        expect_error(
            auto_discover(token, geo_grain = "City", filename = "cities.csv")
        )
    })

    test_that("Missing Arguments", {
        expect_error(auto_discover(token, geo_grain = "State"))
    })

    s1 <- NULL
    test_that("State Array Upload", {
        df <- read.csv("./data/states.csv")
        expect_no_error(
            s1 <<- auto_discover(token, geo_grain = "State", df = df)$signal_id
        )
    })

    s2 <- NULL
    test_that("Country Array Upload", {
        df <- read.csv("./data/country.csv")
        expect_no_error(
            s2 <<- auto_discover(token, geo_grain = "Country", df = df)$signal_id
        )
    })

    s3 <- NULL
    test_that("State File Upload", {
        expect_no_error(
            s3 <<- auto_discover(token, geo_grain = "State", filename = "./data/states.csv")$signal_id
        )
    })

    s4 <- NULL
    test_that("Country File Upload", {
        expect_no_error(
            s4 <<- auto_discover(token, geo_grain = "Country", filename = "./data/country.csv")$signal_id
        )
    })

    # Delete Signals
    test_that("Delete Signals", {
        expect_no_error(delete_signal(token, s1))
        expect_no_error(delete_signal(token, s2))
        expect_no_error(delete_signal(token, s3))
        expect_no_error(delete_signal(token, s4))
    })
}