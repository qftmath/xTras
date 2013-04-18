(****************)
(*              *)
(*    Setup     *)
(*              *)
(****************)

DefConstantSymbol@GiveSymbol["c", #] & /@ Range[5];

(***************************)
(*                         *)
(*  TensorWrapper et. al.  *)
(*                         *)
(***************************)

Test[
	UnitConstant * UnitConstant
	,
	UnitConstant
	,
	TestID->"Algebra-20130103-U3S6O1"
]

Test[
	UnitConstant^RandomInteger[{2,100}]
	,
	UnitConstant
	,
	TestID->"Algebra-20130103-K4Y7X2"
]

Test[
	UnitConstant * TensorWrapper[ UnitConstant ]
	,
	TensorWrapper[ UnitConstant ]
	,
	TestID->"Algebra-20130103-Q1N7G9"
]

Test[
	RemoveTensorWrapper@UnitConstant
	,
	1
	,
	TestID->"Algebra-20130103-G8H6T2"
]

Test[
	TensorWrapper[ K + RicciScalarCD[] + (K + 2) RicciCD[a,b]RicciCD[-a,-b] ]
	,
	K TensorWrapper[ UnitConstant ] + TensorWrapper[ RicciScalarCD[] ] + (K + 2) TensorWrapper[ RicciCD[a,b] RicciCD[-a,-b] ] 
	,
	TestID->"Algebra-20130103-Q5Q9G4"
]

Test[
	RemoveTensorWrapper@TensorWrapper[ K + RicciScalarCD[] + (K + 2) RicciCD[a,b]RicciCD[-a,-b] ]
	,
	K + RicciScalarCD[] + (K + 2) RicciCD[a,b]RicciCD[-a,-b]
	,
	TestID->"Algebra-20130103-N5B4C2"
]

Test[
	RemoveTensors[ K + RicciScalarCD[] + (K + 2) RicciCD[a,b]RicciCD[-a,-b] ]
	,
	K + 1 + K + 2
	,
	TestID->"Algebra-20130103-Z4T6Y3"
]

Test[
	RemoveConstants[ K + RicciScalarCD[] + (K + 2) RicciCD[a,b]RicciCD[-a,-b] ]
	,
	1 + RicciScalarCD[] + RicciCD[a,b]RicciCD[-a,-b]
	,
	TestID->"Algebra-20130103-B0W9N8"
]


(***************************)
(*                         *)
(*        MapTensors       *)
(*                         *)
(***************************)

Test[
	ToCanonical@MapTensors[ VarL[metric[a,b]], RicciScalarCD[] + K ]
	,
	ToCanonical@VarL[metric[a,b]][ RicciScalarCD[] + K ]
	,
	TestID->"Algebra-20130103-B2T3L9"
]

Test[
	MapTensors[unknownFunction, K + RicciScalarCD[] + (K + 2) RicciCD[a,b]RicciCD[-a,-b] ]
	,
	K unknownFunction[1] + unknownFunction[RicciScalarCD[]] + (K + 2) unknownFunction[ RicciCD[a,b]RicciCD[-a,-b] ]
	,
	TestID->"Algebra-20130103-R7R3N2"
]


(***************************)
(*                         *)
(*      CollectTensors     *)
(*                         *)
(***************************)

Test[
	CollectTensors[ 
		metric[a,b] K + 2 metric[a,b] + RiemannCD[a,c,b,d] RicciCD[-c,-d] + 3 K RiemannCD[b,e,a,f] RicciCD[-f,-e]
	]
	,
	(K+2)metric[a,b] + (3K+1) RiemannCD[a,-c,b,-d] RicciCD[c,d]
	,
	TestID->"Algebra-20130103-S8S5H5"
]

Test[
	CollectTensors[ 
		0 == metric[a,b] K + 2 metric[a,b] + RiemannCD[a,c,b,d] RicciCD[-c,-d] + 3 K RiemannCD[b,e,a,f] RicciCD[-f,-e]
	]
	,
	0 == (K+2)metric[a,b] + (3K+1) RiemannCD[a,-c,b,-d] RicciCD[c,d]
	,
	TestID->"Algebra-20130103-S3E0M5"
]

Test[
	CollectTensors[{ 
		metric[a,b] K + 2 metric[a,b] + RiemannCD[a,c,b,d] RicciCD[-c,-d] + 3 K RiemannCD[b,e,a,f] RicciCD[-f,-e],
		2 RiemannCD[a,-g,b,-d] RicciCD[g,d] + 1/K RiemannCD[a,-h,b,-k] RicciCD[h,k]
	}]
	,
	{
		(K+2)metric[a,b] + (3K+1) RiemannCD[a,-c,b,-d] RicciCD[c,d],
		(2 + 1/K) RiemannCD[a,-c,b,-d] RicciCD[c,d]
	}
	,
	TestID->"Algebra-20130103-G2F5H0"
]

Test[
	CollectTensors[Equal[
		metric[a,b] K + 2 metric[a,b] + RiemannCD[a,c,b,d] RicciCD[-c,-d] + 3 K RiemannCD[b,e,a,f] RicciCD[-f,-e],
		2 RiemannCD[a,-g,b,-d] RicciCD[g,d] + 1/K RiemannCD[a,-h,b,-k] RicciCD[h,k]
	]]
	,
	Equal[
		(K+2)metric[a,b] + (3K+1) RiemannCD[a,-c,b,-d] RicciCD[c,d],
		(2 + 1/K) RiemannCD[a,-c,b,-d] RicciCD[c,d]
	]
	,
	TestID->"Algebra-20130103-D7L1K6"
]

Test[
	CollectTensors[ metric[a,b] ]
	,
	metric[a,b]
	,
	TestID->"Algebra-20130103-O1F4P0"
]

Test[
	CollectTensors[ 1 / (1+ RicciScalarCD[] ) + RicciScalarCD[] / (1 + RicciScalarCD[]) ]
	,
	1 / (1+ RicciScalarCD[] ) + RicciScalarCD[] / (1 + RicciScalarCD[])
	,
	CollectTensors::denominator
	,
	TestID->"Algebra-20130103-J4J4K6"
]


(***************************)
(*                         *)
(*     CollectConstants    *)
(*                         *)
(***************************)

Test[
	CollectConstants[
		metric[a,b] (K+1) + 2 K metric[a,b] - K RiemannCD[a,c,b,d] RicciCD[-c,-d] + 3 K RiemannCD[b,e,a,f] RicciCD[-f,-e]
	]
	,
	metric[a,b] + K*(3 metric[a, b] + 2 RicciCD[c, d]*RiemannCD[a, -c, b, -d])
	,
	TestID->"Algebra-20130103-D3C3X0"
]


(****************************)
(*                          *)
(* SolveConstants / Tensors *)
(*                          *)
(****************************)

Test[
	SolveConstants[
		0 == {c1 RicciCD[-a, -b] + c2 RicciCD[-a, -b] , c3 RicciCD[-a, -b], c4 RicciCD[-a, -b]},
		{c1, c3, c4}
	]
	,
	{{c1->-c2,c3->0,c4->0}}
	,
	TestID->"Algebra-20130103-A4V4F8"
]

Test[
	SolveConstants[
		0 == {metric[a,b] K + 1 metric[a,b] + 3 RiemannCD[a,c,b,d] RicciCD[-c,-d] + 3 K RiemannCD[b,e,a,f] RicciCD[-f,-e]}
	]
	,
	{{K->-1}}
	,
	TestID->"Algebra-20130103-W1T0R0"
]

Test[
	SolveConstants[
		0 == metric[a,b] K + 2 metric[a,b] + RiemannCD[a,c,b,d] RicciCD[-c,-d] + 3 K RiemannCD[b,e,a,f] RicciCD[-f,-e],
		{K}
	]
	,
	{}
	,
	TestID->"Algebra-20130223-S6I8X7"
]

Test[
	SolveTensors[metric[a,b] + RicciCD[a,b] == 0, {RicciCD[a,b]}, MakeRule -> False ]
	,
	{{RicciCD[a,b] -> - metric[a,b] }}
	,
	TestID->"Algebra-20130103-V5C1P7"
]

Test[
	SolveTensors[metric[a,b] + RicciCD[a,b] == 0, {RicciCD[__]}, MakeRule -> False ]
	,
	{{RicciCD[a,b] -> - metric[a,b] }}
	,
	TestID->"Algebra-20130223-S0E6R9"
]

Test[
	SolveTensors[metric[a,b] + RicciCD[a,b] == 0, RicciCD[__], MakeRule -> False ]
	,
	{{RicciCD[a,b] -> - metric[a,b] }}
	,
	TestID->"Algebra-20130223-B7Z9V2"
]

Test[
	SolveTensors[metric[a,b] + RicciCD[a,b] == 0, MakeRule -> False ]
	,
	{{RicciCD[a,b] -> - metric[a,b] }}
	,
	Solve::svars
	,	
	TestID->"Algebra-20130223-J1X2G1"
]

Test[
	SolveTensors[metric[a,b] + RicciCD[a,b] == 0, SortMethod -> Reverse, MakeRule -> False ]
	,
	{{metric[a,b] -> - RicciCD[a,b] }}
	,
	Solve::svars
	,
	TestID->"Algebra-20130223-N8Y8T4"
]

Test[
	SolveTensors[metric[a,b] + RicciCD[a,b] == 0, metric[__], MakeRule -> False ]
	,
	{{metric[a,b] -> - RicciCD[a,b] }}
	,
	TestID->"Algebra-20130223-H6H3Q7"
]

Test[
	SolveTensors[RicciScalarCD[] metric[a,b] + RicciCD[a,b] RicciScalarCD[] == 0, MakeRule -> False ]
	,
	{{RicciCD[a, b] -> -metric[a, b]}, {RicciScalarCD[] -> 0}}
	,
	Solve::svars
	,
	TestID->"Algebra-20130418-P4D4O2"
]

Test[
	SolveTensors[RicciScalarCD[] metric[a,b] + RicciCD[a,b] RicciScalarCD[] == 0, MakeRule -> False, BreakInMonomials -> False ]
	,
	{{RicciCD[a, b] RicciScalarCD[] -> -metric[a, b] RicciScalarCD[]}}
	,
	Solve::svars
	,
	TestID->"Algebra-20130418-R7F2C5"
]