module ORM
  class ModelError
    attr_reader :model, :uuid
    attr_accessor :name
    
    def initialize(options={})
      @model    = options[:model]
      @uuid     = options[:uuid] || UUID.generate
      self.name = options[:name]
    end
  end
  
  class ConstraintDuplicateNameError < ModelError; end;
  class ObjectTypeDuplicateNameError < ModelError; end;
  class RecognizedPhraseDuplicateNameError < ModelError; end;
  class GroupDuplicateNameError < ModelError; end;
  class GroupMembershipContradictionError < ModelError; end;
  class ExternalConstraintRoleSequenceArityMismatchError < ModelError; end;
  class FactTypeRequiresInternalUniquenessConstraintError < ModelError; end;
  class FactTypeRequiresReadingError < ModelError; end;
  class TooFewEntityTypeRoleInstancesError < ModelError; end;
  class TooFewFactTypeRoleInstancesError < ModelError; end;
  class TooFewReadingRolesError < ModelError; end;
  class ReadingRequiresUserModificationError < ModelError; end;
  class TooFewRoleSequencesError < ModelError; end;
  class TooManyReadingRolesError < ModelError; end;
  class TooManyRoleSequencesError < ModelError; end;
  
  class DataTypeNotSpecifiedError < ModelError
    attr_accessor :conceptual_data_type_ref
    
    def initialize(options={})
      super
      self.conceptual_data_type_ref = options[:conceptual_data_type_ref]
    end
  end
  
  class NMinusOneError < ModelError; end;
  class CompatibleRolePlayerTypeError < ModelError; end;
  class RolePlayerRequiredError < ModelError; end;
  class EqualityImpliedByMandatoryError < ModelError; end;
  class EntityTypeRequiresReferenceSchemeError < ModelError; end;
  class FrequencyConstraintMinMaxError < ModelError; end;
  class FrequencyConstraintExactlyOneError < ModelError; end;
  class FrequencyConstraintContradictsInternalUniquenessConstraintError < ModelError; end;
  class FrequencyConstraintViolatedByUniquenessConstraintError < ModelError; end;
  class MinValueMismatchError < ModelError; end;
  class MaxValueMismatchError < ModelError; end;
  class ValueRangeOverlapError < ModelError; end;
  class ValueTypeDetachedError < ModelError; end;
  class RingConstraintTypeNotSpecifiedError < ModelError; end;
  class ImplicationError < ModelError; end;
  class SubsetConstraintImpliedByMandatoryConstraintsError < ModelError; end;
  class EqualityConstraintImpliedByMandatoryConstraintsError < ModelError; end;
  class ExclusionContradictsMandatoryError < ModelError; end;
  class NotWellModeledSubsetAndMandatoryError < ModelError; end;
  class ImpliedInternalUniquenessConstraintError < ModelError; end;
  class ObjectTypeRequiresPrimarySupertypeError < ModelError; end;
  class PreferredIdentifierRequiresMandatoryError < ModelError; end;
  class CompatibleSupertypesError < ModelError; end;
  class ObjectifyingInstanceRequiredError < ModelError; end;
  class ObjectifiedInstanceRequiredError < ModelError; end;
  class CompatibleValueTypeInstanceValueError < ModelError; end;
  class PopulationMandatoryError < ModelError; end;
  class PopulationUniquenessError < ModelError; end;
  class ExclusionContradictsEqualityError < ModelError; end;
  class ExclusionContradictsSubsetError < ModelError; end;
end
