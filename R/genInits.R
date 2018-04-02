#' Generate initialization for optimization
#'
#' @param nstart Number of starts for optimization
#' @param max.start.time Maximum amount of time to select each start in seconds
#' @param W absolute abundance
#' @param M sample size
#' @param X mean covariates
#' @param X_star overdispersion covariates
#' @param np number of mean parameters
#' @param npstar number of overdisperion parameters
#' @param link Link function for mean
#' @param phi.link Link function for overdispersion
#' @param logpar Indicator of log-likelihood
#' @param lower Lower bound for parameter values. Defaults to -20
#' @param upper Upper bound for parameter values. Defaults to 20.
#'
#' @return Matrix of initializations
#'
#' @examples
#' \dontrun{
#' TODO
#' }
#' @export
genInits <- function(nstart, max.start.time,
                     W, M,
                     X, X_star,
                     np, npstar,
                     link, phi.link, logpar,
                     lower = NULL, upper = NULL) {

  if (is.null(lower)) {
    lower <- rep(-20, np + npstar)
  }
  if (is.null(upper)) {
    upper <- rep(20, np + npstar)
  }

  inits <- matrix(NA, nrow = nstart, ncol = np + npstar)
  for (i in 1:nstart) {
    inits[i,] <- GenSA::GenSA(fn = dbetabin, lower = lower, upper = upper, W = W, M = M, X = X, X_star = X_star, np = np,
                         npstar = npstar, link = link, phi.link = phi.link, logpar = logpar, control = list(max.time = max.start.time))$par
  }


  return(inits)
}