module POEditor
  class UI
    @@enabled = false

    def self.enabled
      @@enabled
    end

    def self.enabled=enabled
      @@enabled = enabled
    end

    def self.puts(*args)
      Kernel.puts args.map { |x| x.to_s }.join(" ") if @@enabled
    end
  end
end
