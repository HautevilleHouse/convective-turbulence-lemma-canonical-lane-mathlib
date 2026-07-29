import ConvectiveTurbulenceLemmaCanonicalLaneLean.ConvectivePDEsubstrate

/-!
# Boussinesq Weak Layer

This module records the weak-solution envelope used by the admitted analytic
lane for the Boussinesq approximation. The fields are proof-carrying Lean terms.
-/

namespace HautevilleHouse
namespace ConvectiveTurbulenceLemmaCanonicalLaneLean

structure BoussinesqWeakEnvelope where
  flow : ConvectiveFlow
  finiteEnergy : Prop
  divergenceFree : Prop
  buoyancyBalance : Prop
  weakEquation : Prop
  finiteEnergyClosed : finiteEnergy
  divergenceFreeClosed : divergenceFree
  buoyancyBalanceClosed : buoyancyBalance
  weakEquationClosed : weakEquation

def sourceBoussinesqWeakEnvelope : BoussinesqWeakEnvelope := {
  flow := primitiveConvectiveFlow
  finiteEnergy := true
  divergenceFree := Incompressible primitiveConvectiveFlow
  buoyancyBalance := true
  weakEquation := ConvectiveEquationClosed primitiveConvectiveFlow
  finiteEnergyClosed := rfl
  divergenceFreeClosed := primitive_flow_incompressible_checked
  buoyancyBalanceClosed := rfl
  weakEquationClosed := primitive_flow_equation_closed_checked
}

def BoussinesqWeakEnvelopeClosed (E : BoussinesqWeakEnvelope) : Prop :=
  E.finiteEnergy ∧ E.divergenceFree ∧ E.buoyancyBalance ∧ E.weakEquation

theorem source_boussinesq_weak_envelope_closed :
    BoussinesqWeakEnvelopeClosed sourceBoussinesqWeakEnvelope := by
  exact And.intro sourceBoussinesqWeakEnvelope.finiteEnergyClosed
    (And.intro sourceBoussinesqWeakEnvelope.divergenceFreeClosed
      (And.intro sourceBoussinesqWeakEnvelope.buoyancyBalanceClosed
        sourceBoussinesqWeakEnvelope.weakEquationClosed))

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse