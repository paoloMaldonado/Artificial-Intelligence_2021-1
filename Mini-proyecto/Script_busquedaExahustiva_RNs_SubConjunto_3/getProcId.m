
function Id = getProcId()

NET.addAssembly('System');
p = System.Diagnostics.Process.GetCurrentProcess();
Id = p.Id;