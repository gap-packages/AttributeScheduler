This file describes changes in the AttributeScheduler package.

## Unreleased

- Require GAP >= 4.9
- No longer suggest GAPDoc
- Add a license file

## 0.1 (2025-04-15)

- First release: scheduling attribute computations via a graph built with
  `AttributeSchedulerGraph`, `AddAttribute` and `AddPropertyIncidence`,
  with automatic method installation for its attributes
- Allow requirements on graph edges, computed on the fly
- Speed up `ComputeProperty` by a factor of about 1.5
- Add examples to the manual (#17)
