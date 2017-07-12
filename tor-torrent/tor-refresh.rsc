/tool fetch url=http://linux-host/tor.rsc

# Disable info logging to avoid log spam
:foreach rule in=[/system logging find] do={
    :if ([:find [/system logging get $rule topics] "info" -1] > -1) do={
        /system logging disable $rule
    }
}

import tor.rsc

# Re-enable info logging
:foreach rule in=[/system logging find] do={
    :if ([:find [/system logging get $rule topics] "info" -1] > -1) do={
        /system logging enable $rule
    }
}
