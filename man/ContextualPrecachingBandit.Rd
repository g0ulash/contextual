% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bandit_cmab_precaching.R
\name{ContextualPrecachingBandit}
\alias{ContextualPrecachingBandit}
\title{Bandit: ContextualPrecachingBandit}
\description{
Illustrates precaching of contexts and rewards.
}
\details{
TODO: Fix "attempt to select more than one element in integerOneIndex"

Contextual extension of \code{\link{BasicBernoulliBandit}}.

Contextual extension of \code{\link{BasicBernoulliBandit}} where a user specified \code{d x k} dimensional
matrix takes the place of \code{\link{BasicBernoulliBandit}} \code{k} dimensional probability vector. Here,
each row \code{d} represents a feature with \code{k} reward probability values per arm.

For every \code{t}, \code{ContextualPrecachingBandit} randomly samples from its \code{d} features/rows at
random, yielding a binary \code{context} matrix representing sampled (all 1 rows) and unsampled (all 0)
features/rows. Next, \code{ContextualPrecachingBandit} generates \code{rewards} contingent on either sum or
mean (default) probabilities of each arm/column over all of the sampled features/rows.
}
\section{Usage}{

\preformatted{
  bandit <- ContextualPrecachingBandit$new(weights)
}
}

\section{Arguments}{


\describe{
\item{\code{weights}}{
numeric matrix; \code{d x k} dimensional matrix where each row \code{d} represents a feature with
\code{k} reward probability values per arm.
}
}
}

\section{Methods}{


\describe{

\item{\code{new(weights)}}{ generates
and instantializes a new \code{ContextualPrecachingBandit} instance. }

\item{\code{get_context(t)}}{
argument:
\itemize{
\item \code{t}: integer, time step \code{t}.
}
returns a named \code{list}
containing the current \code{d x k} dimensional matrix \code{context$X},
the number of arms \code{context$k} and the number of features \code{context$d}.
}

\item{\code{get_reward(t, context, action)}}{
arguments:
\itemize{
\item \code{t}: integer, time step \code{t}.
\item \code{context}: list, containing the current \code{context$X} (d x k context matrix),
\code{context$k} (number of arms) and \code{context$d} (number of context features)
(as set by \code{bandit}).
\item \code{action}:  list, containing \code{action$choice} (as set by \code{policy}).
}
returns a named \code{list} containing \code{reward$reward} and, where computable,
\code{reward$optimal} (used by "oracle" policies and to calculate regret).
}

\item{\code{generate_bandit_data()}}{
helper function called before \code{Simulator} starts iterating over all time steps \code{t} in T.
Pregenerates \code{contexts} and \code{rewards}.
}
}
}

\examples{
\dontrun{

horizon            <- 100L
simulations        <- 100L

# rows represent features, columns represent arms:

context_weights    <- matrix(  c(0.4, 0.2, 0.4,
                                 0.3, 0.4, 0.3,
                                 0.1, 0.8, 0.1),  nrow = 3, ncol = 3, byrow = TRUE)

bandit             <- ContextualPrecachingBandit$new(weights)

agents             <- list( Agent$new(EpsilonGreedyPolicy$new(0.1), bandit),
                            Agent$new(LinUCBDisjointOptimizedPolicy$new(0.6), bandit))

simulation         <- Simulator$new(agents, horizon, simulations)
history            <- simulation$run()

plot(history, type = "cumulative")

}
}
\seealso{
Core contextual classes: \code{\link{Bandit}}, \code{\link{Policy}}, \code{\link{Simulator}},
\code{\link{Agent}}, \code{\link{History}}, \code{\link{Plot}}

Bandit subclass examples: \code{\link{BasicBernoulliBandit}}, \code{\link{ContextualLogitBandit}},
\code{\link{OfflineReplayEvaluatorBandit}}

Policy subclass examples: \code{\link{EpsilonGreedyPolicy}}, \code{\link{ContextualLinTSPolicy}}
}
