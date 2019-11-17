options(prompt="R> ", error=traceback)
local({
    r = getOption("repos")
    r["CRAN"] = "https://cran.rstudio.com/"
    options(repos = r)
})
ht = function(d, n=6) rbind(head(d,n),tail(d,n))

hh = function(d) d[1:5,1:5]

read.csv <- function (file, header = TRUE, sep = ",", quote = "\"", dec = ".", fill = TRUE, comment.char = "", stringsAsFactors = default.stringsAsFactors(), ...) {
    if (stringsAsFactors) {
        stop('For the sake of your sanity, set stringsAsFactors to FALSE!')
    } 
    read.table(file = file, header = header, sep = sep, quote = quote, dec = dec, fill = fill, comment.char = comment.char,  stringsAsFactors = stringsAsFactors)
}

