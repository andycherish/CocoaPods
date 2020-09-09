module Pod
  class Command
    module Options
      # Provides support for commands to take a user-specified `project directory`
      #
      module PodfileEnvironment
        module Options
          def options
            [
              ['--podfile-environment=env', 'The environment name of podfile'],
            ].concat(super)
          end
        end

        def self.included(base)
          base.extend(Options)
        end

        def initialize(argv)
          if podfile_environment = argv.option('podfile-environment')
            @podfile_environment = podfile_environment
            if config.podfile_path
              config.podfile_path = config.podfile_path.sub_ext('.' + @podfile_environment + '.rb')
            else 
              config.podfile_path = (config.installation_root + 'Podfile').sub_ext('.' + @podfile_environment + '.rb')
            end
          end
          super
        end

        def validate!
          super
        end
      end
    end
  end
end
