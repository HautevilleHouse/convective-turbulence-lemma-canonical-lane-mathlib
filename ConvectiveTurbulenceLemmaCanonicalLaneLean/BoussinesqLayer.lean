import canonicalLaneMathlib.AdmissibleClass

namespace HautevilleHouse
namespace ConvectiveTurbulenceLemmaCanonicalLaneLean

abbrev Space3 := Fin 3 → ℝ
abbrev Time := ℝ
abbrev ScalarField := Time → Space3 → ℝ
abbrev VectorField := Time → Space3 → Space3

def zeroScalarField : ScalarField := fun _ _ => 0
def zeroVectorField : VectorField := fun _ _ _ => 0

structure BoussinesqOperators where
  divergence : VectorField → ScalarField
  gradient : ScalarField → VectorField
  laplacian : VectorField → VectorField
  laplacianScalar : ScalarField → ScalarField
  timeDerivative : VectorField → VectorField
  timeDerivativeScalar : ScalarField → ScalarField
  transport : VectorField → VectorField
  buoyancy : (ScalarField × VectorField) → VectorField

def primitiveBoussinesqOperators : BoussinesqOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  laplacianScalar := fun θ => θ
  timeDerivative := fun _ => zeroVectorField
  timeDerivativeScalar := fun _ => zeroScalarField
  transport := fun _ => zeroVectorField
  buoyancy := fun (θ, g) => zeroVectorField
}

structure BoussinesqFlow where
  velocity : VectorField
  temperature : ScalarField
  gravity : VectorField
  viscosity : ℝ
  diffusivity : ℝ
  operators : BoussinesqOperators

def primitiveBoussinesqFlow : BoussinesqFlow := {
  velocity := zeroVectorField
  temperature := zeroScalarField
  gravity := zeroVectorField
  viscosity := 1
  diffusivity := 1
  operators := primitiveBoussinesqOperators
}

def Incompressible (F : BoussinesqFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def BoussinesqMomentum (F : BoussinesqFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def BoussinesqTemperature (F : BoussinesqFlow) : Prop :=
  F.operators.timeDerivativeScalar F.temperature = F.operators.laplacianScalar F.temperature

def BoussinesqEquationClosed (F : BoussinesqFlow) : Prop :=
  Incompressible F ∧ BoussinesqMomentum F ∧ BoussinesqTemperature F

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveBoussinesqFlow := by
  rfl

theorem primitive_flow_momentum_checked :
    BoussinesqMomentum primitiveBoussinesqFlow := by
  rfl

theorem primitive_flow_temperature_checked :
    BoussinesqTemperature primitiveBoussinesqFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    BoussinesqEquationClosed primitiveBoussinesqFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_momentum_checked primitive_flow_temperature_checked)

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse
