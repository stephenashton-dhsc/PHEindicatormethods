#test calculations
test_that("isrates and CIs calculate correctly",{

  expect_equal(data.frame(select(calculate_ISRate(select(test_ISR_ownref,-refcount,-refpop), count, pop,
                                  x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop),1:7,9:10)),
               data.frame(select(slice(test_ISR_results,1:3),1:7,10:11)),
               check.attributes=FALSE, check.names=FALSE,info="test default")

  expect_equal(data.frame(select(calculate_ISRate(select(test_ISR_ownref,-count, -refcount,-refpop), total_count, pop,
                                   x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop,
                                   observed_totals = test_ISR_lookup), 1:7,9:10)),
               data.frame(select(slice(test_ISR_results,1:3),1:7,10:11)),
               check.attributes=FALSE, check.names=FALSE,info="test default with observed_totals")

  expect_equal(data.frame(select(calculate_ISRate(select(test_ISR_ownref,-refcount,-refpop), count, pop, confidence = c(0.95,0.998),
                                         x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop),1:9,11:12)),
               data.frame(slice(test_ISR_results,1:3)),
               check.attributes=FALSE, check.names=FALSE,info="test full output with 2 CIs")

  expect_equal(data.frame(select(calculate_ISRate(test_ISR_ownref, count, pop, refcount, refpop,
                                         refpoptype="field", type="standard"), 1:7)),
               data.frame(select(slice(test_ISR_results,1:3),1:7)),
               check.attributes=FALSE, check.names=FALSE,info="test default with own ref data by col name")

  expect_equal(data.frame(calculate_ISRate(select(test_ISR_ownref,-refcount,-refpop), count, pop,
                                  test_ISR_ownref$refcount[1:19], test_ISR_ownref$refpop[1:19], type="standard")),
               data.frame(select(slice(test_ISR_results,1:3),1:7)),
               check.attributes=FALSE, check.names=FALSE,info="test default with own ref data as vector")

  expect_equal(data.frame(calculate_ISRate(test_err2, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, type="standard")),
               data.frame(select(slice(test_ISR_results,13:14),1:7)),
               check.attributes=FALSE, check.names=FALSE,info="test zero population")

  expect_equal(data.frame(calculate_ISRate(select(test_ISR_ownref,-refcount,-refpop), count, pop, type="standard",
                       x_ref = c(10303,2824,NA,3615,3641,3490,3789,3213,3031,2771,3089,3490,3595,4745,5514,7125,5694,6210,5757),
                       n_ref = c(50520,57173,60213,54659,44345,50128,62163,67423,62899,55463,60479,49974,44140,40888,37239,30819,18136,15325,13918))),
               data.frame(select(slice(test_ISR_results,1:3),1:7)),
               check.attributes=FALSE, check.names=FALSE,info="test ref as specified vector")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, type="standard")),
               data.frame(select(slice(test_ISR_results,1:3),1:7)),
               check.attributes=FALSE, check.names=FALSE,info="test standard")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, confidence = c(0.95,0.998), type="standard")),
               data.frame(select(slice(test_ISR_results,1:3),1:9)),
               check.attributes=FALSE, check.names=FALSE,info="test standard 2 CIs")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, type="value")),
               data.frame(select(slice(test_ISR_results,1:3),1,5)),
               check.attributes=FALSE, check.names=FALSE,info="test value")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, confidence = c(0.95,0.998),  type="value")),
               data.frame(select(slice(test_ISR_results,1:3),1,5)),
               check.attributes=FALSE, check.names=FALSE,info="test value 2 CIs")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, type="lower")),
               data.frame(select(slice(test_ISR_results,1:3),1,6)),
               check.attributes=FALSE, check.names=FALSE,info="test lower")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, confidence = c(0.95,0.998),  type="lower")),
               data.frame(select(slice(test_ISR_results,1:3),1,6,8)),
               check.attributes=FALSE, check.names=FALSE,info="test lower 2 CIs")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop,type="upper")),
               data.frame(select(slice(test_ISR_results,1:3),1,7)),
               check.attributes=FALSE, check.names=FALSE,info="test upper")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, confidence = c(0.95,0.998), type="upper")),
               data.frame(select(slice(test_ISR_results,1:3),1,7,9)),
               check.attributes=FALSE, check.names=FALSE,info="test upper 2 CIs")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, type="standard", x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop,confidence = 99.8)),
               data.frame(select(slice(test_ISR_results,1:3),1:5,8:9)),
               check.attributes=FALSE, check.names=FALSE,info="test confidence")

  expect_equal(data.frame(calculate_ISRate(test_multiarea, count, pop, type="standard", x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop, multiplier=1000)),
               data.frame(select(slice(test_ISR_results,4:6),1:7)),
               check.attributes=FALSE, check.names=FALSE,info="test multiplier")

  expect_equal(data.frame(select(calculate_ISRate(select(test_ISR_ownref,-refcount,-refpop), count, pop, confidence = c(0.95,0.998),
                                  x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop),1:7)),
               data.frame(select(slice(test_ISR_results,1:3),1:7)),
               check.attributes=FALSE, check.names=FALSE,info="test two CIS 95%")

  expect_equal(data.frame(select(calculate_ISRate(test_multiarea, count, pop, type="standard", x_ref = test_ISR_refdata$refcount,
                                  n_ref = test_ISR_refdata$refpop,confidence = c(0.95, 0.998)),1:5,8,9)),
               data.frame(select(slice(test_ISR_results,1:3),1:5,8:9)),
               check.attributes=FALSE, check.names=FALSE,info="test two CIs 99.8")

  expect_equal(data.frame(select(ungroup(calculate_ISRate(select(test_ISR_ownref,-refcount,-refpop), count, pop, confidence = c(0.95,0.998),
                                         x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop)),10)),
               data.frame(confidence = rep("95%, 99.8%",3), stringsAsFactors=FALSE),
               check.attributes=FALSE, check.names=FALSE,info="test two CIS metadata")

})




# test error handling

test_that("isrates - errors are generated when invalid arguments are used",{

  expect_error(calculate_ISRate(test_multiarea, count, pop),
               "function calculate_ISRate requires at least 5 arguments: data, x, n, x_ref and n_ref",info="error invalid number of arguments")

  expect_error(calculate_ISRate(test_err1, count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop),
               "numerators must all be greater than or equal to zero",info="error numerators < 0")

  expect_error(calculate_ISRate(test_err3, count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop),
               "denominators must all be greater than or equal to zero",info="error denominator < 0")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop, confidence = 0.74),
               "confidence level must be between 90 and 100 or between 0.9 and 1",info="error confidence < 0.9")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop, confidence = 3),
               "confidence level must be between 90 and 100 or between 0.9 and 1",info="error confidence between 1 and 90")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop, confidence = 1000),
               "confidence level must be between 90 and 100 or between 0.9 and 1",info="error confidence >100")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop, type="combined"),
               "type must be one of value, lower, upper, standard or full",info="error invalid type")

  expect_error(calculate_ISRate(filter(test_multiarea,count < 100), count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop),
               "data must contain the same number of rows for each group",info="error num rows per group")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount[1:18], n_ref = test_ISR_refdata$refpop),
               "x_ref length must equal number of rows in each group within data",info="error x_ref length")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount, n_ref = test_ISR_refdata$refpop[2:19]),
              "n_ref length must equal number of rows in each group within data",info="error n_ref length")

  expect_error(calculate_ISRate(test_ISR_ownref, count, pop, test_ISR_ownref$refcount, test_ISR_ownref$refpop[1:19]),
               "x_ref length must equal number of rows in each group within data",info="error x_ref length in data")

  expect_error(calculate_ISRate(test_ISR_ownref, count, pop, test_ISR_ownref$refcount[1:19], test_ISR_ownref$refpop),
               "n_ref length must equal number of rows in each group within data",info="error n_ref length in data")

  expect_error(calculate_ISRate(test_multiarea, count, pop, test_ISR_ownref$refcount[1:19], test_ISR_ownref$refpop, refpoptype = "column"),
               "valid values for refpoptype are vector and field",info="error invalid refpoptype")

  expect_error(calculate_ISRate(test_ISR_ownref, count, pop, ref_count, refpop, refpoptype = "field"),
               "x_ref is not a field name from data",info="error x_ref not a field name")

  expect_error(calculate_ISRate(test_ISR_ownref, count, pop, refcount, ref_pop, refpoptype = "field"),
               "n_ref is not a field name from data",info="error n_ref not a field name")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                       n_ref = test_ISR_refdata$refpop, confidence = c(0.95, 0.998, 0.98)),
               "a maximum of two confidence levels can be provided",info="error max two CIs")

  expect_error(calculate_ISRate(test_multiarea, count, pop, x_ref = test_ISR_refdata$refcount,
                       n_ref = test_ISR_refdata$refpop, confidence = c(0.95, 0.98)),
               "two confidence levels can only be produced if they are specified as 0.95 and 0.998",
               info="error invalid number of arguments")

})


