import canonicalLaneMathlib.AdmissibleClass
import HautevilleHouse.ConvectiveTurbulenceLemmaCanonicalLaneLean.TurbulenceAnalyticObjects

namespace HautevilleHouse
namespace ConvectiveTurbulenceLemmaCanonicalLaneLean

structure WeakSolutionEnvelope where
  flow : TurbulenceFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  energyInequality : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  energyInequalityClosed : energyInequality
  weakEquationClosed : weakEquation

def sourceWeakSolutionEnvelope : WeakSolutionEnvelope := {
  flow := primitiveFlow,
  finiteEnergy := true,
  divergenceFree := Incompressible primitiveFlow,
  energyInequality := true,
  weakEquation := TurbulenceEquationClosed primitiveFlow,
  finiteEnergyClosed := rfl,
  divergenceFreeClosed := primitive_flow_incompressible_checked,
  energyInequalityClosed := rfl,
  weakEquationClosed := primitive_flow_equation_closed_checked
}

def WeakSolutionEnvelopeClosed (E : WeakSolutionEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.energyInequality ∧ E.weakEquation

theorem source_weak_solution_envelope_closed :
    WeakSolutionEnvelopeClosed sourceWeakSolutionEnvelope := by
  exact And.intro sourceWeakSolutionEnvelope.finiteEnergyClosed
    (And.intro sourceWeakSolutionEnvelope.divergenceFreeClosed
      (And.intro sourceWeakSolutionEnvelope.energyInequalityClosed
        sourceWeakSolutionEnvelope.weakEquationClosed))

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse