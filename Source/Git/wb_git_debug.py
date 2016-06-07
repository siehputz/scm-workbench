'''
 ====================================================================
 Copyright (c) 2016 Barry A Scott.  All rights reserved.

 This software is licensed as described in the file LICENSE.txt,
 which you should have received as part of this distribution.

 ====================================================================

    wb_git_debug.py

'''
import wb_debug

class WbGitDebug(wb_debug.WbDebug):
    def __init__( self ):
        # assumes derived class sets self.log
        self._debug_git_project = False
        self._debug_log_history = False

        super().__init__()

    # wb_git_project
    def _debugGitProject( self, msg ):
        if self._debug_git_project:
            self.log.debug( 'GIT-PROJECT %s' % (msg,) )

    def _debugLogHistory( self, msg ):
        if self._debug_log_history:
            self.log.debug( 'LOG-HISTORY %s' % (msg,) )
