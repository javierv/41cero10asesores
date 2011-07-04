class ActionDispatch::Request
 def local_with_test?
   if Rails.env.test?
     false
   else
     local_without_test?
   end
 end

 alias_method_chain :local?, :test
end
