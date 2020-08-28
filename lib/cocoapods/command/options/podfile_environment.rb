module Pod
  class Command
    module Options
      # Provides support for commands to take a user-specified `project directory`
      #
      module PodfileEnvironment
        module Options
          def options
            [
              ['--podfile_environment=env', 'The env of podfile'],
            ].concat(super)
          end
        end

        def self.included(base)
          base.extend(Options)
        end

        def initialize(argv)
          if podfile_environment = argv.option('podfile_environment')
            @podfile_environment = podfile_environment
          end
          if config.podfile_path
            config.podfile_path = config.podfile_path.sub_ext('.' + @podfile_environment + '.rb')
          else 
            config.podfile_path = (config.installation_root + 'Podfile').sub_ext('.' + @podfile_environment + '.rb')
          end
          super
        end

        def validate!
          super
          if @project_directory && !@project_directory.directory?
            raise Informative, "`#{@project_directory}` is not a valid directory."
          end
        end
      end
    end
  end
end
