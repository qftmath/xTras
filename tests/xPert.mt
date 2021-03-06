(****************)
(*              *)
(*    Setup     *)
(*              *)
(****************)

DefConstantSymbol[L];
SetOptions[ToBackground, BackgroundSolution -> SymmetricSpaceRules[CD,K] ];


(*******************)
(*                 *)
(*   VarL et.al.   *)
(*                 *)
(*******************)

Test[
	ToCanonical[
		ExpandPerturbation@Perturbation[Detmetric[]]
		- Detmetric[]*Perturbationmetric[LI[1], a, -a]
	]
	,
	0
	,
	TestID->"xPert-20130102-I4S7W1"
]

Test[
	Perturbation[ metric[-a,-b] ]
	,
	Perturbationmetric[LI[1],-a,-b]
	,
	TestID->"xPert-20130102-L4S5X5"
]

Test[
	Detmetric[] // Perturbation // ExpandPerturbation // ContractMetric // ToCanonical // ScreenDollarIndices
	,
	Detmetric[] * Perturbationmetric[LI[1], a, -a]
	,
	TestID->"xPert-20140923-T3L2W7"
]

DetMetricDiff[n_]:=
	ToCanonical @ ContractMetric[
		+ ExpandPerturbation @ Perturbation[#, n] & @ Detmetric[]
		- Nest[ExpandPerturbation@Perturbation[#]&, Detmetric[], n]
	]

Test[
	DetMetricDiff[1]
	,
	0
	,
	TestID->"xPert-20140924-F7E5E6"
]

Test[
	DetMetricDiff[2]
	,
	0
	,
	TestID->"xPert-20140923-C1M6D2"
]

Test[
	DetMetricDiff[3]
	,
	0
	,
	TestID->"xPert-20140923-N2I5K4"
]

Test[
	DetMetricDiff[4]
	,
	0
	,
	TestID->"xPert-20140923-F5O8U7"
]

Test[
	DetMetricDiff[5]
	,
	0
	,
	TestID->"xPert-20140923-Y5T2W0"
]

Test[
	ToCanonical@VarL[metric[a, b], CD][RicciScalarCD[]]
	,
	RicciCD[-a, -b] - metric[-a, -b]/2 RicciScalarCD[]
	,
	TestID->"xPert-20130102-F7R9V5"
]

Test[
	ToCanonical[
		ContractMetric@VarL[metric[a, b], CD][RicciCD[a,b]RicciCD[-a,-b]]
		- ( 2 RicciCD[-a, c] RicciCD[-b, -c] - 1/2 metric[-a, -b] RicciCD[-c, -d] RicciCD[c, d]
		  - CD[-c]@CD[-a]@RicciCD[-b, c] - CD[-c]@CD[-b]@RicciCD[-a, c] 
		  + CD[-c]@CD[c]@RicciCD[-a, -b] + metric[-a, -b] CD[-d]@CD[-c]@RicciCD[c, d] )
	]
	,
	0
	,
	TestID->"xPert-20130102-R9V2O6"
]

(******************************)
(*                            *)
(*  Background perturbations  *)
(*                            *)
(******************************)

Test[
	ToCanonical@ToBackground[ RiemannCD[a,b,c,d] ]
	,
	K metric[a, c] metric[b, d] - K metric[a, d] metric[b, c]
	,
	TestID->"xPert-20130102-O9G7K5"
]

Test[
	Simplification@ContractMetric@ToBackground[
		RiemannCD[-a,-b,-c,-d] RiemannCD[a,b,c,d] - KretschmannCD[]
	]
	,
	0
	,
	TestID->"xPert-20130106-O1E5Y3"
]

Test[
	Simplification@ContractMetric[ 
		ToBackground@RicciCD[a,b] 
		- metric[-c,-d] ToBackground@RiemannCD[a,c,b,d]
	]
	,
	0
	,
	TestID->"xPert-20130102-U8I2G8"
]

Test[
	Simplification@ContractMetric[ 
		ToBackground@RicciScalarCD[] 
		- metric[-a,-b] ToBackground@RicciCD[a,b]
	]
	,
	0
	,
	TestID->"xPert-20130102-F6A2P6"
]

Test[
	Simplification@ToBackground[ TFRicciCD[a,b]  - TFRicciToRicci@TFRicciCD[a,b] ]
	,
	0
	,
	TestID->"xPert-20130102-A5Q9E4"
]


Test[
	Simplification@ToBackground[ WeylCD[a,b,c,d]  - WeylToRiemann@WeylCD[a,b,c,d] ]
	,
	0
	,
	TestID->"xPert-20130102-C0F5U9"
]

Test[
	Simplification@ToBackground[ SchoutenCD[a,b]  - SchoutenToRicci@SchoutenCD[a,b] ]
	,
	0
	,
	TestID->"xPert-20130102-K6Q0V2"
]

Test[
	Simplification@ToBackground[ EinsteinCD[a,b]  - EinsteinToRicci@EinsteinCD[a,b] ]
	,
	0
	,
	TestID->"xPert-20130102-L4I9O6"
]

Test[
	Simplification@ToBackground[ SchoutenCCCD[LI[L],a,b]  - SchoutenCCToRicci@SchoutenCCCD[LI[L],a,b] ]
	,
	0
	,
	TestID->"xPert-20130102-F6H0U7"
]

Test[
	Simplification@ToBackground[ EinsteinCCCD[LI[L],a,b]  - EinsteinToRicci@EinsteinCCCD[LI[L],a,b] ]
	,
	0
	,
	TestID->"xPert-20130102-F3J1M8"
]

Test[
	Simplification@PerturbBackground[RicciScalarCD[]^2]
	,
	2*(dim-1)*dim*K*Perturbation[RicciScalarCD[]]
	,
	TestID->"xPert-20130102-V6E5P0"
]

Test[
	Simplification@ContractMetric[
		ExpandBackground[RicciScalarCD[]]
		- ((K - dim*K)*Perturbationmetric[LI[1], a, -a] + 
 		  CD[-b][CD[-a][Perturbationmetric[LI[1], a, b]]] - 
 		  CD[-b][CD[b][Perturbationmetric[LI[1], a, -a]]])
	]
	,
	0
	,
	TestID->"xPert-20130102-U8R5L9"
]

Test[
	PD[-e]@metric[-f,-d] /. FlatRules[CD] 
	,
	0
	,
	TestID->"xPert-20130124-M1S8X7"
]
