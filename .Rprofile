options(prompt="R> ", error=traceback)
local({
    r = getOption("repos")
    r["CRAN"] = "https://cran.rstudio.com/"
    options(repos = r)
})
ht = function(d, n=6) rbind(head(d,n),tail(d,n))

hh = function(d) d[1:5,1:5]
