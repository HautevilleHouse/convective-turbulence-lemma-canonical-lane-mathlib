import ConvectiveTurbulenceLemmaCanonicalLaneLean.RegularityEndpointLayer

namespace HautevilleHouse
namespace ConvectiveTurbulenceLemmaCanonicalLaneLean

def ConstrainedConvectiveTurbulenceClosure (A : AdmissibleClass) : Prop :=
  bridgeClosed A ∧ gateClosed A

theorem constrained_convective_turbulence_endgame (A : AdmissibleClass) :
    ConstrainedConvectiveTurbulenceClosure A := by
  exact And.intro (bridge_from_admissible_class A) (gate_from_admissible_class A)

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse