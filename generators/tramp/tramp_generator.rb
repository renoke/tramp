class TrampGenerator < MigrationGenerator
  
  def initialize(runtime_args, runtime_options={})
    super(["tramp_migration"])
  end
  
  def manifest
    record do |m|
      m.migration_template( 'create_tramp.rb', 'db/migrate')
    end
  end
end
