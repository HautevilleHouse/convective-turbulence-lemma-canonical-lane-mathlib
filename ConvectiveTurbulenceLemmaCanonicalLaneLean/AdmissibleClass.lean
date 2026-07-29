import ConvectiveTurbulenceLemmaCanonicalLaneLean.MathlibObjects

namespace HautevilleHouse
namespace ConvectiveTurbulenceLemmaCanonicalLaneLean

structure AdmissibleClass where
  object : AdmittedTheoremObject
  endpointSatisfied : Prop
  remainderRecorded : Prop
  gateWitness : endpointSatisfied ∨ remainderRecorded

def admittedClosure (A : AdmissibleClass) : Prop :=
  NativeBridgeClosed A.object ∧ (A.endpointSatisfied ∨ A.remainderRecorded)

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse