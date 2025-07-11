'use client'

import { createBrowserClient } from '@supabase/ssr'

console.log('URL:', process.env.NEXT_PUBLIC_SUPABASE_URL)
console.log('KEY:', process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY)

export function createClient() {
  return createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
  )
}
