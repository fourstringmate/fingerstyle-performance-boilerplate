% Boilerplate for Fingerstyle Performance.
%
% Copyright (c) 2024 Jenna Chen.  Licensed under MIT


% Set compatible LilyPond version.
\version "2.22.1"

% Adjust the size of a sheet music.
#(set-global-staff-size 22)

% Set the tuning of the lute-family instrument.
tuning = \stringTuning <g d' g' d''>

% The parameters used by a piece.
piece-title = "The Title"
piece-composer = "The Composer"
piece-parameter = {
    % Set the clef.
    \clef treble
    % Set the key signature.
    \key c \major
    % Set the time signature.
    \numericTimeSignature
    \time 4/4
    % Set the tempo.
    \tempo "Moderato"
}
% A baritone ukulele is not supported as a MIDI instrument.
% A nylon guitar is used instead.
piece-instrument = "acoustic guitar (nylon)"

% Record the chords of a piece.
% \chords is a builtin command in LilyPond.
% Don't use chords as a variable name.
chord = \chordmode {
    % Don't show any text when no chord set.
    % Replace the default "N.C." to save space.
    \set noChordSymbol = ""

    % Write your chord names here.
    s1 s1
    \bar "|."  % The end of a piece.
}

% Record the melody of a piece.
melody = {
    % Write your melody here.
    g4 d' g' d'' <g d' g' d''>1
    \bar "|."
}

% Record the piece.
piece = {
    <<
    % Create the chord name part.
    \tag #'chord \new ChordNames {
        \piece-parameter
        \chord
    }

    % Create the sheet music.
    \new Staff \with {
        midiInstrument = \piece-instrument
    } {
        \piece-parameter
        \melody
    }

    % Create the tablature.
    \new TabStaff \with {
        stringTunings = #tuning
    } {
        \melody
    }
    >>
}

\book {
    \header {
        title = \piece-title
        composer = \piece-composer
        % Remove the default footer.
        tagline = ##f
    }

    \markup { \vspace #2.5 }

    % Create the MIDI for a piece.
    % We can explore a piece freely before your ensemble play it.
    \score {
        % Keep the chord names from the MIDI output.
        \removeWithTag #'chord
        \piece
        \midi {}
    }

    % Create the sheet music.
    \score {
        \piece

        \layout {
            % Remove the indentation.
            indent = #0
            % Disable line filling.
            ragged-right = ##t
            % Disable line filling on the last line.
            ragged-last = ##t
        }
    }

    \paper {
        score-markup-spacing.basic-distance = #5
    }
}
