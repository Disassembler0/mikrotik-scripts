/tool fetch url=http://linux-host/country-xx.rsc

# Disable info logging to avoid log spam
:foreach rule in=[/system logging find] do={
    :if ([:find [/system logging get $rule topics] "info" -1] > -1) do={
        /system logging disable $rule
    }
}

import country-xx.rsc

# Re-enable info logging
:foreach rule in=[/system logging find] do={
    :if ([:find [/system logging get $rule topics] "info" -1] > -1) do={
        /system logging enable $rule
    }
}
