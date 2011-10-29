########################
## GALL REMOVAL EXP'T ##
### SPATIAL ANALYSIS ###
########################

# analysis for 2010-2011 sg1 data
# with spatial correlations

# 28 Oct 2011

library(bbmle)

d = read.csv(
	'~/documents/DATA/2010 DATA/FIELD/sg1/sg1-2010-2011-DONOTCHANGE.csv')
d = d[-115,]
D = dist(cbind(d$x, d$y))

Nt = d$galls2010_TOTAL
Nt1 = d$galls2011_TOTAL

nll.nb1 = function(r, k, s){
	lik = dnbinom(x=Nt1, mu = Nt * exp(r * (1 - Nt / k)),
		size=s, log=TRUE)
	-sum(lik)
}


nll.nb1(r=0.4, k=6, s=0.5)


nb0 = mle2(Nt1 ~ dnbinom(mu=mu, size=s), 
	start=list(mu=3, s=0.5), data=list(Nt1, Nt))
nb0.5 = mle2(Nt1 ~ dnbinom(mu=Nt, size=s), 
	start=list(s=0.5), data=list(Nt1, Nt))
nb0.5 = mle2(Nt1 ~ dnbinom(mu=r * Nt, size=s), 
	start=list(s=0.5, r=1), data=list(Nt1, Nt))

nb1 = mle2(nll.nb1, start=list(r=0.4, k=6, s=0.5),
	data=list(Nt, Nt1), method='Nelder-Mead')

nll.H = 



