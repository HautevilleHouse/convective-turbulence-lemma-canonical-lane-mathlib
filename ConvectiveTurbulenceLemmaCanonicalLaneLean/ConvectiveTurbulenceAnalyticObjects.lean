import ConvectiveTurbulenceLemmaCanonicalLaneLean.AdmissibleClass
import Mathlib.Data.Real.Basic

/-!
# Convective Turbulence Analytic Objects

This module defines the local analytic vocabulary for convective turbulence:
fluid velocity, temperature, density, and the Boussinesq operators.
-/

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
  timeDerivative : VectorField → VectorField
  advection : VectorField → VectorField
  buoyancy : VectorField → ScalarField
  dissipation : VectorField → VectorField
  pressureProjection : VectorField → VectorField
  pressureProjectionIdempotent : ∀ u, pressureProjection (pressureProjection u) = pressureProjection u

def primitiveBoussinesqOperators : BoussinesqOperators := {
  divergence := fun _ => zeroScalarField
  gradient := fun _ => zeroVectorField
  laplacian := fun u => u
  timeDerivative := fun _ => zeroVectorField
  advection := fun _ => zeroVectorField
  buoyancy := fun _ => zeroScalarField
  dissipation := fun _ => zeroVectorField
  pressureProjection := fun u => u
  pressureProjectionIdempotent := by intro u; rfl
}

structure ConvectiveFlow where
  velocity : VectorField
  temperature : ScalarField
  density : ScalarField
  viscosity : ℝ
  thermalDiffusivity : ℝ
  operators : BoussinesqOperators

def primitiveConvectiveFlow : ConvectiveFlow := {
  velocity := zeroVectorField
  temperature := zeroScalarField
  density := zeroScalarField
  viscosity := 1
  thermalDiffusivity := 1
  operators := primitiveBoussinesqOperators
}

def Incompressible (F : ConvectiveFlow) : Prop :=
  F.operators.divergence F.velocity = zeroScalarField

def BoussinesqBalance (F : ConvectiveFlow) : Prop :=
  F.operators.timeDerivative F.velocity = F.operators.laplacian F.velocity

def TemperatureAdvection (F : ConvectiveFlow) : Prop :=
  F.operators.advection F.velocity = zeroVectorField

def ConvectiveEquationClosed (F : ConvectiveFlow) : Prop :=
  Incompressible F ∧ BoussinesqBalance F ∧ TemperatureAdvection F

theorem primitive_pressure_projection_idempotent_checked (u : VectorField) :
    primitiveBoussinesqOperators.pressureProjection (primitiveBoussinesqOperators.pressureProjection u) =
      primitiveBoussinesqOperators.pressureProjection u := by
  rfl

theorem primitive_flow_incompressible_checked :
    Incompressible primitiveConvectiveFlow := by
  rfl

theorem primitive_flow_boussinesq_balance_checked :
    BoussinesqBalance primitiveConvectiveFlow := by
  rfl

theorem primitive_flow_temperature_advection_checked :
    TemperatureAdvection primitiveConvectiveFlow := by
  rfl

theorem primitive_flow_equation_closed_checked :
    ConvectiveEquationClosed primitiveConvectiveFlow := by
  exact And.intro primitive_flow_incompressible_checked
    (And.intro primitive_flow_boussinesq_balance_checked primitive_flow_temperature_advection_checked)

end ConvectiveTurbulenceLemmaCanonicalLaneLean
end HautevilleHouse