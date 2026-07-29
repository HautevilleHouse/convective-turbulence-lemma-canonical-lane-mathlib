import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectiveTurbulenceLemmaCanonicalLaneLean

structure TurbulenceSpecificObject where
  sourceKey : String
  theoremObject : String
  claimBoundary : String
deriving Repr, DecidableEq

structure AdmittedTurbulenceObject where
  object : TurbulenceSpecificObject
  localWitness : String
  bridgeEvidence : String
  sourceKeyChecked : object.sourceKey = sourceRepository
  theoremObjectChecked : object.theoremObject = sourceDescription

structure TurbulenceClosureState where
  object : AdmittedTurbulenceObject

def sourceRepository : String := "convective-turbulence-lemma-canonical-lane"
def sourceDescription : String := "Convective Turbulence Lemma"

def turbulenceSpecificObject : TurbulenceSpecificObject := {
  sourceKey := sourceRepository,
  theoremObject := sourceDescription,
  claimBoundary := "Boundedness of convective term via admissible bridge"
}

def NativeBridgeClosed (O : AdmittedTurbulenceObject) : Prop :=
  O.object.sourceKey = sourceRepository ∧ O.object.theoremObject = sourceDescription

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse