require 'xcodeproj'

path_to_project = 'Mockingbird.xcodeproj'
project = Xcodeproj::Project.open(path_to_project)

FRAMEWORKS = %w[MockServer MockServerKit ResourceKit SwaggerKit TestKit].freeze

# Removes a folder reference (i.e. blue folder) from a project
def remove_folder_reference(project, folder_name)
  folder_path = "#{Dir.pwd}/#{folder_name}"

  folder_reference = project.reference_for_path(folder_path)

  folder_reference.remove_from_project unless folder_reference.nil?
end

# Remove unneccessary folder references
remove_folder_reference(project, 'Reports')
remove_folder_reference(project, 'Resources')
remove_folder_reference(project, 'Utility')

project.targets.each do |target|
  next unless FRAMEWORKS.include?(target.name)

  # Add Resources to ResourceKit Bundle
  if target.name == 'ResourceKit'
    resource_path = "#{Dir.pwd}/Resources"

    # Add new group reference (i.e. tan folder)
    resource_group = project.new_group('Resources', './Resources')

    # Add new copy files build phase
    copy_phase = target.new_copy_files_build_phase

    # Add the resources to the group and build phase
    Dir.foreach(resource_path) do |item|
      next if ['.', '..'].include?(item)

      file = resource_group.new_reference(item)
      copy_phase.add_file_reference(file)
    end
  end

  # Add Swiftlint as a build script phase
  phase = target.new_shell_script_build_phase('Swiftlint')
  phase.shell_script = './Utility/swiftlint_xcode.sh'

  # Enable treating warnings as errors
  target.build_configurations.each do |config|
    config.build_settings['SWIFT_TREAT_WARNINGS_AS_ERRORS'] = 'YES'
  end
end

project.save
