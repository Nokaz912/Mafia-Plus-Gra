package pl.mafia.backend.models;

import jakarta.persistence.*;
import lombok.Data;
import lombok.ToString;

import java.util.List;

@Entity
@Table(name = "Account")
@Data
public class Account {
    @Id
    @ToString.Exclude
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "account_sequence")
    @SequenceGenerator(name = "account_sequence", sequenceName = "ACCOUNT_SEQ", allocationSize = 1)
    private Long id;

    @Column(unique = true, nullable = false)
    private String login;

    @ToString.Exclude
    @Column(nullable = false)
    private String password;

    @Column(unique = true, nullable = false)
    private String email;

    @Column(nullable = false)
    private String nickname;

    @ToString.Exclude
    @ManyToOne
    @JoinColumn(name = "id_room")
    private Room room;

    @ToString.Exclude
    @ManyToMany
    @JoinTable(name = "GameAccount", joinColumns = @JoinColumn(name = "id_account"), inverseJoinColumns = @JoinColumn(name = "id_game"))
    private List<Game> games;

    @ToString.Exclude
    @OneToMany(mappedBy = "account")
    private List<RoundMiniGame> roundMiniGames;

    @ToString.Exclude
    @OneToMany(mappedBy = "account")
    private List<Voting> votings;

    @ToString.Exclude
    @OneToMany(mappedBy = "voter")
    private List<Vote> votesAsVoter;

    @ToString.Exclude
    @OneToMany(mappedBy = "voted")
    private List<Vote> votesAsVoted;
}
