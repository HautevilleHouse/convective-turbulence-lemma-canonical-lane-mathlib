import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectiveTurbulenceLemmaCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure TurbulenceOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  timeDerivative : VectorField → VectorField
  convectiveDerivative : VectorField → VectorField → VectorField
  divergenceFreeProjection : VectorField → VectorField
  divergenceFreeProjectionIdempotent : ∀ u, divergenceFreeProjection (divergenceFreeProjection u) = divergenceFreeProjection u

def primitiveOperators : TurbulenceOperators := {
  divergence := fun _ => zeroScalarField,
  gradient := fun _ => zeroVectorField,
  laplacian := fun u => u,
  timeDerivative := fun _ => zeroVectorField,
  convectiveDerivative := fun _ _ => zeroVectorField,
  divergenceFreeProjection := fun u => u,
  divergenceFreeProjectionIdempotent := by intro u; rfl
}

structure TurbulenceFlow where
  velocity : VectorField
  pressure : ScalarField
  viscosity : ℝ
  operators : TurbulenceOperators

def primitiveFlow : TurbulenceFlow := {
  velocity := zeroVectorField,
  pressure := zeroScalarField,
  viscosity := 1,
  operators := primitiveOperators
}

def Incompressible (F : TurbulenceFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def ConvectiveBalance (F : TurbulenceFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.convectiveDerivative F.velocity F.velocity

def DivergenceFreeProjected (F : TurbulenceFlow) : Prop :=
  F.operators.divergenceFreeProjection F.velocity = F.velocity

def TurbulenceEquationClosed (F : TurbulenceFlow) : Prop :=
  Incompressible F ∧ ConvectiveBalance F ∧ DivergenceFreeProjected F

theorem primitive_divergence_free_projection_idempotent_checked (u : VectorField) :
    primitiveOperators.divergenceFreeProjection (primitiveOperators.divergenceFreeProjection u) = primitiveOperators.divergenceFreeProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveFlow := by
  rfl

theorem primitive_flow_convective_balance_checked :
    ConvectiveBalance primitiveFlow := by
  rfl

theorem primitive_flow_divergence_free_projected_checked :
    DivergenceFreeProjected primitiveFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    TurbulenceEquationClosed primitiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_convective_balance_checked primitive_flow_divergence_free_projected_checked)

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse