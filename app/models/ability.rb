class Ability
  include CanCan::Ability
  
  # ******************************************************
  # PERMISSIONS
  #
  # A permission is made up of a subject (model class name),
  # the actions you can take on it. Depending on the action,
  # there could be conditions that apply. For example,
  # a Sales Manager may only be allowed to see their own territory.
  #
  PERMISSIONS = [
    { :subject => "Customer", :label => "Customers", :permissions => [
      { :action => "view", :desc => "Can view customers"},
      { :action => "create", :desc => "Can create a new customer"},
      { :action => "update", :desc => "Can edit existing customers"},
      { :action => "delete", :desc => "Can delete customers"}
    ]}, 
    
    { :subject => "Supplier", :label => "Suppliers", :permissions => [
      { :action => "view", :desc => "Can view suppliers"},
      { :action => "create", :desc => "Can create a new supplier"},
      { :action => "update", :desc => "Can edit existing suppliers"},
      { :action => "delete", :desc => "Can delete suppliers"}
    ]},
    
    { :subject => "UnitOfMeasure", :label => "UOM", :permissions => [
      { :action => "view", :desc => "Can view unit of measures"},
      { :action => "create", :desc => "Can create a new unit of measure"},
      { :action => "update", :desc => "Can edit existing unit of measures"},
      { :action => "delete", :desc => "Can delete unit of measures"}
    ]},
    
    { :subject => "Department", :label => "Departments", :permissions => [
      { :action => "view", :desc => "Can view departments"},
      { :action => "create", :desc => "Can create a new department"},
      { :action => "update", :desc => "Can edit existing departments"},
      { :action => "delete", :desc => "Can delete departments"}
    ]},
    
    { :subject => "RawMaterialType", :label => "RM Types", :permissions => [
      { :action => "view", :desc => "Can view rm types"},
      { :action => "create", :desc => "Can create a new rm type"},
      { :action => "update", :desc => "Can edit existing rm types"},
      { :action => "delete", :desc => "Can delete rm types"}
    ]},
    
    { :subject => "User", :label => "Users", :permissions => [
      { :action => "view", :desc => "Can view users"},
      { :action => "create", :desc => "Can create a new user"},
      { :action => "update", :desc => "Can edit existing users"},
      { :action => "delete", :desc => "Can delete users"}
    ]},
    
    { :subject => "Role", :label => "Roles", :permissions => [
      { :action => "view", :desc => "Can view roles"},
      { :action => "create", :desc => "Can create a new role"},
      { :action => "update", :desc => "Can edit existing roles"},
      { :action => "delete", :desc => "Can delete roles"}
    ]},
    
    { :subject => "RawMaterial", :label => "Raw Materials", :permissions => [
      { :action => "view", :desc => "Can view raw materials"},
      { :action => "create", :desc => "Can create a new raw material"},
      { :action => "update", :desc => "Can edit existing raw materials"},
      { :action => "delete", :desc => "Can delete raw materials"},
      { :action => "transactions", :desc => "Can view raw material transactions"}
    ]},
    
    { :subject => "RawMaterialTransaction", :label => "Raw Material Transactions", :permissions => [
      { :action => "create", :desc => "Can create a new raw material transaction"},
      { :action => "update", :desc => "Can edit existing raw material transactions"},
      { :action => "delete", :desc => "Can delete raw materials tranasctions"}
    ]},
    
    { :subject => "Supply", :label => "Supplies", :permissions => [
      { :action => "view", :desc => "Can view supplies"},
      { :action => "create", :desc => "Can create a new supply"},
      { :action => "update", :desc => "Can edit existing supplies"},
      { :action => "delete", :desc => "Can delete supplies"},
      { :action => "transactions", :desc => "Can view supply transactions"}
    ]},
    
    { :subject => "SupplyTransaction", :label => "Supply Transactions", :permissions => [
      { :action => "create", :desc => "Can create a new supply transaction"},
      { :action => "update", :desc => "Can edit existing supply transactions"}
    ]},
    
    { :subject => "FinishedGood", :label => "Finished Goods", :permissions => [
      { :action => "view", :desc => "Can view finished goods"},
      { :action => "create", :desc => "Can create a new finished good"},
      { :action => "update", :desc => "Can edit existing finished goods"},
      { :action => "delete", :desc => "Can delete finished goods"},
      { :action => "transactions", :desc => "Can view finished good transactions"}
    ]},
    
    { :subject => "FinishedGoodTransaction", :label => "Finished Good Transactions", :permissions => [
      { :action => "create", :desc => "Can create a new finished good transaction"}
    ]},
    
    { :subject => "Bag", :label => "Bags", :permissions => [
      { :action => "return", :desc => "Can return bags"}
    ]},
    
    { :subject => "Mixer", :label => "Mixers", :permissions => [
      { :action => "view", :desc => "Can view mixers"},
      { :action => "create", :desc => "Can create a new mixer"},
      { :action => "update", :desc => "Can edit existing mixers"},
      { :action => "delete", :desc => "Can delete mixers"}
    ]},
    
    { :subject => "Extruder", :label => "Extruders", :permissions => [
      { :action => "view", :desc => "Can view extruders"},
      { :action => "create", :desc => "Can create a new extruder"},
      { :action => "update", :desc => "Can edit existing extruders"},
      { :action => "delete", :desc => "Can delete extruders"}
    ]},
    
    { :subject => "Formula", :label => "Formulas", :permissions => [
      { :action => "view", :desc => "Can view formulas"},
      { :action => "create", :desc => "Can create a new formula"},
      { :action => "update", :desc => "Can edit existing formulas"},
      { :action => "delete", :desc => "Can delete formulas"}
    ]},
    
    { :subject => "IssuedFormula", :label => "Issued Formulas", :permissions => [
      { :action => "view", :desc => "Can view issued formulas"},
      { :action => "create", :desc => "Can create a new issued formula"},
      { :action => "update", :desc => "Can update an issued formula"},
      { :action => "cancel", :desc => "Can cancel an issued formula"},
      { :action => "process", :desc => "Can process issued formulas"}
    ]},
    
    { :subject => "IssuedFormulaBatch", :label => "Issued Formula Batches", :permissions => [
      { :action => "view", :desc => "Can view issued formula batches"},
      { :action => "create", :desc => "Can create a new issued formula batch"},
      { :action => "update", :desc => "Can update an issued formula batch"},
      { :action => "delete", :desc => "Can delete an issued formula batch"}
    ]},
    
    { :subject => "CostingPeriod", :label => "Costing Period", :permissions => [
      { :action => "view", :desc => "Can view costing periods"},
      { :action => "create", :desc => "Can create a new costing period"},
      { :action => "update", :desc => "Can update a costing period"},
      { :action => "delete", :desc => "Can delete a costing period"}
    ]},
    
    { :subject => "SalesQuote", :label => "Sales Quote", :permissions => [
      { :action => "view", :desc => "Can view sales quotes"},
      { :action => "create", :desc => "Can create a new sales quote"},
      { :action => "update", :desc => "Can update a sales quote"},
      { :action => "delete", :desc => "Can delete a sales quote"}
    ]},
    
    { :subject => "CoqProperty", :label => "COQ Properties", :permissions => [
      { :action => "view", :desc => "Can view coq properties"},
      { :action => "create", :desc => "Can create a new coq property"},
      { :action => "update", :desc => "Can update a coq property"},
      { :action => "delete", :desc => "Can delete a coq property"}
    ]},
    
    { :subject => "CertificateOfQuality", :label => "Certificate of Quality", :permissions => [
      { :action => "view", :desc => "Can view COQs"},
      { :action => "create", :desc => "Can create a new COQ"},
      { :action => "update", :desc => "Can update a COQ"},
      { :action => "delete", :desc => "Can delete a COQ"}
    ]},
    
    { :subject => "GeneratedCertificateOfQuality", :label => "Generated Certificate of Quality", :permissions => [
      { :action => "create", :desc => "Can create a new generated COQ"}
    ]},
    
    { :subject => "Truck", :label => "Truck", :permissions => [
      { :action => "view", :desc => "Can view trucks"},
      { :action => "create", :desc => "Can create a new truck"},
      { :action => "update", :desc => "Can update a truck"},
      { :action => "delete", :desc => "Can delete a truck"}
    ]},
    
    { :subject => "Position", :label => "Position", :permissions => [
      { :action => "view", :desc => "Can view positions"},
      { :action => "create", :desc => "Can create a new position"},
      { :action => "update", :desc => "Can update a position"},
      { :action => "delete", :desc => "Can delete a position"}
    ]}
  ]

  def initialize(user)
    if user.has_role?("admin")
      can :manage, :all
    else
      user.roles.each do |role|
        self.establish_permissions(role, user)
      end
      
      alias_action :view, :to => :read
    end
  end
  
  def establish_permissions(role, user)
    role = Role.find_by_name(role) if role.is_a?(String)
    return if role.nil?

    if role.permissions && role.permissions.is_a?(Hash)
      role.permissions.each do |subject, perms|
        subject = subject.classify
        perms.each do |action_name, val|
          unless val.blank? || val.to_s == "0"
            can action_name.to_sym, subject.constantize
          end
        end
      end
    end
  end

  def self.permissions(role)

    role = Role.find_by_name(role) if role.is_a?(String)
    return if role.nil?

    list = PERMISSIONS.clone
    list.each do |o|
      o[:permissions].each do |perm|
        perm[:input] = perm[:options].nil? ? "checkbox" : "dropdown"
        perm[:value] = ""
      end
    end
    list
  end
end
